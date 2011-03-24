Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 90-46-11-204.rar.beartech.net ([204.11.46.90]:24846 "EHLO
	exchsrvr.taosinc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934262Ab1CXUwl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2011 16:52:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Proposed interface for Light Sensor ADC integration time
Date: Thu, 24 Mar 2011 15:52:41 -0500
Message-ID: <B4B07CCC7B7A084E989CF9386538EA1D63AA02@exchsrvr.taosinc.com>
From: "Jon Brenner" <jbrenner@TAOSinc.com>
To: <linux-iio@vger.kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All,
I have been trying to find/fit an appropriate ABI for a light sensor
(ALS type) device driver, user accessible parameter.
The parameter of discussion is the device ADC 'integration time'.
This integration time is typically specified in ms.

I have considered 'illuminance0_sampling_frequency', but somehow it
doesn't seem to fit as sampling frequency implies number of samples to
be taken vs the internal ADC charge time itself.
ADC integration time when used in conjunction with other tunable
parameters affords the user ability to maximize resolution over response
time, and thus a valuable interface particularly in ALS/PROX devices .

The intention is to create an attribute that is more or less generic for
light sensor devices.

I would like to propose;
For ALS devices - illuminance0_integration_time.
For PROX devices - proximity-integration time.

Your comments are welcome, and thanks for your consideration! 

Jon
