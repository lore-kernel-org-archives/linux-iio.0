Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE9443C21;
	Tue, 22 Sep 2026 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110491; cv=none; b=OWlOnhJJ+7fDtdWayuxv4rBDA2AzERrYVwdi5zlv9phjl8uZHq/v3ezCYL5NjO8UrZl6jXKBfs4i0NkD0JUkhvMiakrBcmcJzBeKEqheWEKWAWeraf8aw6a5eainNMeH3xbamP2UKq3pKRvsO6T/7dBs4PW/gFmagchmOdA6fZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110491; c=relaxed/simple;
	bh=VsLSunsMvVz//xQmePqVGCMacsnDx6oddn6bENpdoS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNVYb2taCY8fRwa+ZBeBsEBWY3p73XOlVsXkE0QZC0PiZ4aJ7oy4I/S3fiOoBbx+uCnrBlSLMbCRV7Q2zJslOuAAcggXHdwyPIHMWvyjyGSNqPAhvu/++zJQ5SOyr5zEQyXmWPsPzgTvJ1QK6BN9kgcjvvsxEYDo7cGgUalpt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=AjCDKuVV; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AjCDKuVV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790110398; x=1790715198; i=w_armin@gmx.de;
	bh=T1i5F+7vGeVPTGvc0kwQ2jh2bLQUIAMPMdrJOa5e8Io=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AjCDKuVV1+nHXyo94enzs1Rjqukf8n8vMi1m/j+HzVEoLbCBW8dL1hO8+5IDIomT
	 +uENGR3HaJMLuFui5Be7YTdCq0AEjIhHptf2g6ztIx/ck1JijY/3pH9iEugwo/Prk
	 BVyxwfv7NBKQD36lx4XRuWlvqgw8HBhsG7aJKDxwPRHR0KHvtvGchW0N6wjGxDkWc
	 tvPsx+Ovkcy5+Xa7oEsPbFoq2WE2z3L6nOrIYcKLR6V1BPIi249yvxX+DMC0Sabkx
	 MvGSyrlkJEmTuNHoETi6iX91Z20/tm1sofQRmxa1as8vO3lORjXpWgiXHXQVdyEBw
	 pKTngYTftUEbb/gAfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatRZ-1wbhPa1zZb-00aGCR; Tue, 22
 Sep 2026 22:53:17 +0200
Message-ID: <f6eb60e0-e318-4846-a906-31cb965ccb15@gmx.de>
Date: Tue, 22 Sep 2026 22:53:09 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i3c: add i3cdev character device module for
 user-space access
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Cc: linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
 vitor.soares@toradex.com, samagazaryan@google.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, boris.brezillon@collabora.com,
 oleksandr.shulzhenko.viktorovych@intel.com, tgopinath@linux.microsoft.com,
 corbet@lwn.net, skhan@linuxfoundation.org, linux@roeck-us.net,
 Frank.Li@nxp.com, jorge.marques@analog.com, pgaj@cadence.com,
 wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
 nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
 dlechner@baylibre.com, andy@kernel.org, lorenzo@kernel.org,
 enelsonmoore@gmail.com, rppt@kernel.org, pratyush@kernel.org,
 giovanni.cabiddu@intel.com, gabewhigham@gmail.com, haren@linux.ibm.com,
 pasha.tatashin@soleen.com, jirislaby@kernel.org,
 adrian.ho.yin.ng@altera.com, ustc.gu@gmail.com, jszhang@kernel.org,
 adrian.hunter@intel.com, akhilrajeev@nvidia.com, tze.yee.ng@altera.com,
 manikanta.guntupalli@amd.com, shubhrajyoti.datta@amd.com,
 jarkko.nikula@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
 <aqVUyYkpKT8iX4Jz@ashevche-desk.local>
 <20260916-454d66ca84cc91479b195aa5@linux.microsoft.com>
 <aqt_dCazxTDR4cpk@ashevche-desk.local>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <aqt_dCazxTDR4cpk@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bnFIj5lioxLUfSCVkhDACEAGRbIYvro8/B1Uqfve6Wu/9imE8AA
 tGXyI5tEGM+3UNdQsCjPwHc6zFq2QCWiIUFkDn+O7B0IqPW0tNpBSHDcILFUgNULxqED+yP
 1AVMrP96RvBT2ibiJCOzovkRbVRiQpzVhIvlY8wFfb1zpB8FJKexabFK5bpm7/AM9reOC8m
 uijm5GfRvO3eT04MZ8JIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LxlTluHVd8Q=;OJD9y/fMc6uBWVOEV75Aac45Ygm
 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
 TqzQ1EJghxMiEqmYSlwXSW

Am 17.09.26 um 07:49 schrieb Andy Shevchenko:

> On Wed, Sep 16, 2026 at 03:57:10PM -0700, Meagan Lloyd wrote:
>> On Sat, Sep 12, 2026 at 04:34:01PM +0300, Andy Shevchenko wrote:
>>> On Fri, Sep 11, 2026 at 02:09:35PM -0700, Meagan Lloyd wrote:
>>>> The i3cdev driver is a character device driver that allows user-space
>>>> to control and interact with I3C devices.
>>>> Currently, it has the ability to perform Single Data Rate (SDR)
>>>> transfers - basic reads/writes.
>>>>
>>>> With the addition of sysfs driver_override, there is now a
>>>> straightforward and direct way to match the i3cdev driver to any i3c
>>>> device without stepping on the toes of more specialized drivers that =
are
>>>> loaded automatically.
>>> Is it safe? Why on the earth do we need this? The commit message has n=
ot enough
>>> information.
>> I can't see a reason that it'd be unsafe. To give additional confidence=
,
>> it's already in-use in many bus_types:
> This argument has nothing to do with i=C2=B3c. Each bus is different on =
a physical
> layer, electrical protocols and programming flow. Each of them has own
> constraints.
>
>> To answer why we need it:
>> If we want to write i3cdev as a standard device driver, it can't
>> actually match anything by default. This is because, some devices on th=
e
>> system may need specific drivers and i3cdev is generic and should
>> technically match every device.
> Yes, but I have seen no reason why we should expose i=C2=B3c bus to the =
user
> space. With i=C2=B2c we already know very well that it was (and still is=
)
> a bad idea. Why i=C2=B3c is better (especially taking into account i=C2=
=B2c
> compatible mode and more complex programming flow)?

Hi,

in my experience sometimes during driver development you want to access th=
e device
directly to test things, but of course this is incredibly unsafe.

I think we should taint the kernel as soon as userspace applications perfo=
rm raw
i3c accesses, but the idea itself is fine from my point of view.

Thanks,
Armin Wolf

>> Since the driver_override is default NULL and is set via sysfs, this
>> allows any specific drivers on boot to be loaded up and would allow
>> explicit control on what device i3cdev gets bound to.
>>
>> This was my rational. I will refine the commit message with more detail=
s.
> Put a real life example why the exposing i=C2=B3c devices into user spac=
e is
> absolutely necessary.
>
>>>> This is accomplished by the i3cdev driver not having any entries in
>>>> the i3c_device_id table. After boot, simply set the driver_override
>>>> to "i3cdev" and bind the device manually via the sysfs bind knob.
>>>> This can also be automated with udev rules as well.
>>>>
>>>> The character device interface will be exposed at: /dev/bus/i3c/<bus
>>>> id>-<Provisional ID>
> ...
>
>>>> +	for (int i =3D 0; i < metadata->nxfers; i++) {
>>> Why is 'i' signed?
>> Mostly for readability and to make sure the line length on loop headers
>> is kept below 80 chars. As a precaution, to make sure that 'i' can
>> represent any metadata->nxfers value without overflow during loops, I
>> check that metadata->nxfers is less than/equal to INT_MAX in
>> get_metadata().
> No need to add useless checks.
>
> ...
>
>>>> +/** + * print_i3c_err() - Prints the I3C error encountered during
>>>> the prior + * call to the core's transfer function.  + * @i3cdev:
>>>> i3cdev_data object + * @metadata: Kernel's copy of i3cdev_xfers
>>>> (ioctl I3CDEV_XFER input) + * @i3c_xfers: i3c_xfer array that was
>>>> sent to the I3C core
>>>> + * Returns: void
>>> Huh?! Where is this coming from?
>> In i3cdev_ioctl_do_xfers, if i3c_device_do_xfers failed, I wanted to
>> print out the first I3C controller error encountered. The controller
>> drivers can set this in the i3c_xfer.err field. Hence this function.
>>
>> It's to aid debugging and provide useful error information.
>> I can certainly refine the wording on the print_i3c_err documentation
>> header to make this more clear.
> My point is about kernel-doc. Why do we need the return section for void=
?
> Where it comes from?
>
>>>> + */
> ...
>
>>> Please, rely less on AI and more on the common sense and
>>> proof-reading.
>> I think I gave you the wrong impression. The new contributions in this
>> series were written and developed by me. I used AI for quality assuranc=
e
>> and cross-referencing. Since I incorporated some AI-flagged suggestions=
,
>> I tried to acknowledge that with the Assisted-by tag.
> I see, then there is a room to improve the code. But the main question i=
s
> why do we even need this whole interface to begin with?
>
