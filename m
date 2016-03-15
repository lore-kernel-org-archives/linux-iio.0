Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35281 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbcCOV4Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2016 17:56:16 -0400
Subject: Re: [PATCH v2 4/5] iio:magnetometer:ak8975: mounting matrix support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1457001111.git.gregor.boirie@parrot.com>
 <022da3dfc0853c6f9820b24c2d9eaaf0c5ccf294.1457001111.git.gregor.boirie@parrot.com>
 <56DAFCEB.6080905@kernel.org> <56E0014D.1040209@parrot.com>
 <56E08B91.6070603@kernel.org> <56E6F2BA.5010101@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E884FE.90005@kernel.org>
Date: Tue, 15 Mar 2016 21:56:14 +0000
MIME-Version: 1.0
In-Reply-To: <56E6F2BA.5010101@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/03/16 17:19, Gregor Boirie wrote:
> On 03/09/2016 09:46 PM, Jonathan Cameron wrote:
> 
> [snip...]
>> Definitely needs ABI docs in Documentation/ABI/testing/sysfs-bus-iio
>> as well. We need the reference directions to be well specified as
>> well - how do we define the main hardware orientation?  on yours presumably
>> the usual approach of using the screen is irrelevant so that definition
>> could be a little 'interesting' to write down?
>>> The standard orientation for us is defined with respect to the drone's head
>>> and the propellers plane, which does not suit the nominal use cases indeed...
>>> Although it really deserves some more detailed documentation, I wonder if the
>>> question is relevant.
>>> Given that the DTS is board specific (correct me if I'm wrong), why not
>>> consider the reference orientation as board specific as well (and make the
>>> whole thing implicit) ?
>> I think that is fine for your sort of usecase - though might be nice to keep
>> a bit of documentation somewhere (perhaps as comments in the DTS), or perhaps
>> more centrally - would be nice for userspace libraries if at least all aircraft
>> had a similar 'default orientation'.
> As you said earlier, things are never that simple. The standard orientation
> may vary with types of UAVs (quad-rotor, fixed wings, bizarre home made UFOs...)
Sure, but let's document what we can so at least some cases are covered
>> For the more 'standard' device with a screen I think we would want to standardise
>> if at all possible.  Most hand held devices have a 'natural' orientation
>> (front facing camera at the top for example).  In those cases we are basically looking
>> at whether the sensor is mounted on the back or the front of the main circuit board and
>> then of course it can be at any rotation in plane but typically is at 90 degrees
>> (hence the inv mpu limitations)
>>
>> I'm guessing there are existing userspace mappings for this.  Perhaps in the Gnome
>> sensors stuff?
> [snip...]
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

