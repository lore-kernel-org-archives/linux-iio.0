Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43532 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbbCINtw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 09:49:52 -0400
Message-ID: <54FDA4FE.4080005@kernel.org>
Date: Mon, 09 Mar 2015 13:49:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH V3 0/9] iio: mma8452 enhancements
References: <20150219141553.27001.18825.stgit@localhost> <alpine.DEB.2.02.1502260009570.6800@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1502260009570.6800@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/02/15 23:11, Peter Meerwald wrote:
> 
>> This series adds some additional features to the mma8452 accelerometer driver
>> 	* debugfs register access
>> 	* transient threshold events
>> 	* highpass filter
>> 	* interrupt driven sampling (trigger)
>> 	* self test mode
> 
> looks good except some very minor things;
> great to see the code is used and enhanced
I'm happy with all the patches I didn't comment on.

Looks good Martin, not much to tidy up!
>  
>> Attributes are added to the core for:
>> * highpass filter for readings
>> * both high and lowpass filters for events
>>
>> In addition a latent bug in the device initialisation is fixed.
>>
>> V3 changes:
>> 	Use 3db frequency for filter enable / disable (0=disable)
>> 	Support enabling filter for readings in addition to events
>> 	Use IIO_EV_INFO_PERIOD rather than custom attribute
>> 	Use devm_iio_trigger_alloc()
>> 	Add comment to explain irq activation during probe()
>> 	iio_device_register() only after all setup
>> 	Drop iio_push_event() wrapper
>> 	Correct parameters to iio_push_event()
>> 	Document missing attributes
>> 	Add self test mode
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

