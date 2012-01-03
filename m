Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-01.vtx.ch ([194.38.175.90]:36852 "EHLO smtp-01.vtx.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab2ACJg7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jan 2012 04:36:59 -0500
Message-ID: <4F02CC55.9080206@flytec.ch>
Date: Tue, 03 Jan 2012 10:37:25 +0100
From: Duss Pirmin <pirmin.duss@flytec.ch>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [Patch v2.1] Adds support for the Texas Instruments ADS1110 adc.
References: <Prayer.1.3.4.1112230809290.970@hermes-2.csi.cam.ac.uk> <1324630944-3668-1-git-send-email-pirmin.duss@flytec.ch> <4EFF699B.1000802@kernel.org>
In-Reply-To: <4EFF699B.1000802@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>> +
>> +	/* read the config register from the chip */
>> +	ret = ads1110_i2c_read_config(chip,&chip->config);
>> +	if (ret != 3)
>> +		goto error_free_dev;
> Any chance this could be ret == 2?  If so you are returning a non
> error in a case where there has been one...  Odd case, but might as
> well get it right.

ads1110_i2c_read_config returns number of bytes read or a negative error 
value. If we could not read three bytes there was an error.

