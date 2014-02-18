Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36655 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbaBRIdy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 03:33:54 -0500
Message-ID: <53031B17.8030608@kernel.org>
Date: Tue, 18 Feb 2014 08:34:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
CC: Ge Gao <GGao@invensense.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	lee.jones@linaro.org
Subject: Re: [PATCH 3/3] iio: imu: inv_mpu6050: Add basic support for mpu9150
References: <1391596475-21986-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <52F623AA.6020905@kernel.org> <E7747D604FBC9F43A71AA431AFF44762104C3FB8@IUSEXCH01.invcorp.invensense.com> <201402101939.46467.manuel.stahl@iis.fraunhofer.de> <E7747D604FBC9F43A71AA431AFF44762104C57AF@IUSEXCH01.invcorp.invensense.com> <52FF5D61.4080506@kernel.org> <20140215133934.GA2579@katana>
In-Reply-To: <20140215133934.GA2579@katana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/14 13:39, Wolfram Sang wrote:
>
>> Wolfram, what do you think?
>>
>> In short we have a device that sits on an i2c bus and supports its own
>> i2c bus (mainly so that the internal processor can use data from devices
>> on that bus) including support for passing the bus straight through.
>> The issues is the dependencies when the intermediate device is sleeping
>> for example.
>
> Just judging from the paragraph above and not digging into the topic
> deeper, I think the idea of an 1-1 multiplexer is suitable. Would the
> pass-throu device then be a MFD? Are the alternative ideas?
>
Seems like overkill to introduce an MFD for this little addition to a fairly
large (and likely to grow driver).  Its a little ugly, but would you mind
if the multiplexer is just handled directly within the  main driver?
(perhaps via a config option).  It would be 'odd' to say the least if
someone really wanted the pass through and not the complex inertial chip
it is part of.

Might just be simpler to do a very trivial mfd with the two parts hanging of it.
The complexity is that the inertial sensor will often take over the device
hanging off it completely so we will need to have it cleanly blocked as busy.

Lee, what do you think?

Jonathan
