Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:55624 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753552AbbKWIbJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2015 03:31:09 -0500
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Phil Reid <preid@electromag.com.au>
Subject: iio: Non multiplexed ADC Data
Message-ID: <5652CEC5.7080804@electromag.com.au>
Date: Mon, 23 Nov 2015 16:31:01 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I'm in th eprocess of writing a driver for a custom ADC controller.
It's an FPGA based ADC controller with multiple ADC channels with a built in DMA master.
All channels share some attributes, eg Sample rate, with other per channel attributes, eg Gain.
The DMA controller de-multiplexes the ADC data by having a separate target buffer for each channel.
Look at the libiio interface this configuration doesn't seem to be catered for.
eg: iio_device_create_buffer creates a single buffer for all enabled channels to share.

The best way I can see is to create an iio device per channel and have them share a common data block.
Not sure what interesting behaviour this may cause.

Or have I missed something obvious..

-- 
Regards
Phil Reid

