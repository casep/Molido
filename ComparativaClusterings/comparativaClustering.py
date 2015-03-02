#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  comparativaClustering.py
#  
#  Copyright 2015 Carlos "casep" Sepulveda <carlos.sepulveda@gmail.com>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

import sys, os 
sys.path.append(os.path.join(os.path.dirname(__file__), '../../RF_Estimation','LIB'))
import csv
import densityPeaks as dp
import numpy as np
from sklearn import metrics
from sklearn import mixture
from sklearn.cluster import SpectralClustering
from sklearn.cluster import KMeans

def main():
	percentageDensityDistance = 0.35
	
	data = []
	with open('/home/casep/Dropbox/Docencia/UTFSM/MsC/Tesis/Data/segmentation.data', 'rb') as csvfile:
		visionData = csv.reader(csvfile, delimiter=',', quotechar='"')
		for row in visionData:
			if len(row) > 12:
				dataRow = []
				dataRow.extend([row[1],row[2],row[3],row[4],row[5],row[6],row[7],row[8],row[9],row[10],row[11],row[12],row[13],row[14],row[15],row[16],row[17],row[18]])
				data.append(dataRow)
	
	clusterData = np.array(data)[1:,:]
	
	clustersNumber, labels = dp.predict(clusterData, percentageDensityDistance)
	print 'clustersNumber',clustersNumber
	print 'fit DensityPeaks',metrics.silhouette_score(clusterData, labels, metric='euclidean')
	
	clustersNumber = 5
	
	km = KMeans(init='k-means++', n_clusters=clustersNumber, n_init=10,n_jobs=-1)
	km.fit(clusterData)
	labels = km.labels_
	print 'fit K-Means',metrics.silhouette_score(clusterData, labels, metric='euclidean')
	
	sc = SpectralClustering(n_clusters=clustersNumber, eigen_solver=None, \
			random_state=None,  n_init=10, gamma=1.0, affinity='nearest_neighbors', \
			n_neighbors=10, eigen_tol=0.0, assign_labels='kmeans', degree=3, \
			coef0=1, kernel_params=None)
	sc.fit(clusterData)
	labels = sc.labels_
	print 'fit Spectral',metrics.silhouette_score(clusterData, labels, metric='euclidean')

	clusterData=np.array(clusterData,dtype=float)
	gmix = mixture.GMM(n_components=clustersNumber, covariance_type='spherical')
	gmix.fit(clusterData)
	labels = gmix.predict(clusterData)
	print 'fit GMM',metrics.silhouette_score(clusterData, labels, metric='euclidean')
	
	
	return 0

if __name__ == '__main__':
	main()

