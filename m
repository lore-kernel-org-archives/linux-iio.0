Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx3.haw-public.haw-hamburg.de ([141.22.6.2]:34391 "EHLO
	mx3.haw-public.haw-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752871Ab3BVJRD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Feb 2013 04:17:03 -0500
Message-ID: <5127353B.1040801@haw-hamburg.de>
Date: Fri, 22 Feb 2013 10:07:07 +0100
From: Carsten Frank <Carsten.Frank@haw-hamburg.de>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>
Subject: driver interface for usb spectrometer (like OceanOptics)
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all.

I have written drivers to access Hamamatsu and Avantes usb-spectrometers 
which express the the following interfaces:
One is located in a subdiretory in the the "/sys/bus/usb/drivers/" tree 
and the other on can be foud in the /dev/ directory.

The first is used to configure the spectrometer (e.g. integration_time, 
gain, etc.) and used to show information like the temperature or the 
wavelength calibration parameters.

The interface in /dev/ is used to aquire the data from the spectrometer 
(typically 2048 x 2 bytes).

Greg (K-H) suggests that the iio interface may be an option so I would 
like to get some opinions.

Thank you very much in advance,

Carsten

