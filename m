Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:50740 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652Ab1JDOPS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2011 10:15:18 -0400
Message-ID: <4E8B16EE.6000708@cam.ac.uk>
Date: Tue, 04 Oct 2011 15:23:42 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: JohnLM <johnlm@apollo.lv>
CC: linux-iio@vger.kernel.org,
	Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de
Subject: Re: [RFC PATCH 0/2] IIO: Filtering - how to handle.
References: <1317377879-9264-1-git-send-email-jic23@cam.ac.uk> <20111004153946.77e9754d@isg005>
In-Reply-To: <20111004153946.77e9754d@isg005>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/11 13:39, JohnLM wrote:
> On Fri, 30 Sep 2011 11:17:57 +0100
> Jonathan Cameron <jic23@cam.ac.uk> wrote:
> 
>> Hi All,
>>
>> One big area we have pretty much glossed over so far is devices with
>> controllable hardware filters.  This RFC proposes one option for
>> how to handle this. For low pass filters at least, the 3db point
>> seems the obvious choice as it allows us to gloss over exactly
>> what type of filter it is whilst still capturing it's basic
>> property of what it lets through.
>>
>> What do people think?
> I have no exact filters in mind but in general since they affect the
> readings I think some kind of framework is needed.
> Some generic types should be defined, but even when IIO can't make out
> what kind of filter it is, user-space app might so it should be exposed.
True.  But how generic do we want and how do we specify it?

The version here assumes that knowing it is low pass is enough, but
is that true.  Do we need to know for example if it is a Butterworth filter?

If we do, does it need to be in the naming?   If not, should we perhaps
have in_voltage_filter_low_pass_type with named filter types?  Perhaps
this also has say butterworth-N for N tap butterworth for example?
Or should be have filter_low_pass_type and filter_low_pass_taps?
Number of taps is often tied up with the 3db point, which would make
things a little interesting.  We might have to buffer the 3db request
and do a hardware update on any of type, taps, 3db_frequency and
sampling frequency changing.  We are already doing that on frequency
in the example given here, so not so bad.

> 
> For filters that can be enabled/disabled userspace could even
> abstract the filtering routine to use hardware filter when desired or
> use software filter when hardware filter is not present or is
> unreliable.
I'm unconvinced that we want to do software filtering in kernel land.
Can't immediately see the point, unless possibly it was used to do
data reduction into a buffer.  Worth keeping in mind, but no something
I can see happening any time soon.
> 
> The implementation is a whole other story I don't have time to think
> about right now. :)
:)
> 
>>
>> Jonathan
>>
>> Jonathan Cameron (2):
>>   staging:iio: filter description - low pass 3db frequency.
>>   staging:iio:imu:adis16400 add control of data filtering.
>>
>>  drivers/staging/iio/iio.h                |    2 +
>>  drivers/staging/iio/imu/adis16400.h      |    2 +
>>  drivers/staging/iio/imu/adis16400_core.c |  177
>> +++++++++++++++++++++++------
>> drivers/staging/iio/industrialio-core.c  |    2 + 4 files changed,
>> 146 insertions(+), 37 deletions(-)
>>
> 
> 

