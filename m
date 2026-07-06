Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1C376A08
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347027; cv=none; b=bmwogcudnPa+g1SLWTtDSsON51d+m77W5hd/AX5pwmT7yvjH3kBS2bk0Xp/GUnJTD/QaYSpirfMljL0ToQnfOnstdMdvKVuGZwZFgSGUJGkyJm2UJwvlzAZfBr7aT32dAYGMl+lJCA51uTw9PQ1HkNshBZWYr4vVOAyVq0i72mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347027; c=relaxed/simple;
	bh=YOsYyrc/bitTU9Vwq6vnx2DmxDDwMmLL4M4U3a7xGto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEDWpm/nP8zsbtW4ec2q4nofSEaZc+pcDlgXSa3qZDqhKTvPg5fE+bJJ56MutZSfim9Yc790abN5ctSaWiS4sxIO3VEMOYidAnzkMxzGenYvngEmgKj5lvb/VRdiPT1f8y3ENfharGRCmdueoBGxNNbfKdxQLh+o8K2XgTLFrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BemTA9d+; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BemTA9d+"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43b7e186a0cso1108446fac.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783347024; x=1783951824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Q13oMYkW312woQm68JTsMT/EHUSwSrALmbtYHd4pkc=;
        b=BemTA9d+p0hVaw+VZWUV9RDD8Tmrcy8wb0aKRfBZYWTL+6d+v9nTaMMF/+R1Iorf61
         vS1c9imyQ34K6uPtXHR9XTuVOSuWwzWd1BxzqQR65Nmn5Z14MWn8d9RMn2iStcZ4WoKO
         pK0i8QoEQrZGkrdeZ9nLReGOzL52FS3Q8pqAdZiAlASXXy8v/cMApyNrDzW6RC+Tm4KC
         4JWGl0Ln/0QHxLwfEABPd7e3KtkvviPRTd1pcnPEyT50oGLHoUNr1CBr4wWUFolqQUoq
         XDoSq8LnY7Kt8sSATQgPi8lcNBFjQhsTlDmLTnMMA1yx3wSX/PTIXgHPZCYOLEwmwPKm
         XQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783347024; x=1783951824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Q13oMYkW312woQm68JTsMT/EHUSwSrALmbtYHd4pkc=;
        b=cbZ+a5waj9CCeOe8JB3TpU4NSAzO7qu2uC09YUkjHG8RoKj9T3N1EEdGOQrDKnrI8W
         7pk8LhRdgI407zBoXVMH0F2jyaDlisf/sLcB9uZUmorB+bBQTj8gmQ/sPLsAyWcGyX7T
         ND9dbc6PTUw6YYN0vIwNoonI5usj7xVcB0+3zAISlqDnWezDoxWI5rTYUw2N7w0CiWvZ
         4hfL6YjP8acBDH91rSw/L6BtpzA50pl80c5wi8jFFHW/qYFRN3t5zvplsAbIMElMKcTC
         lLwjBp81XsmzeyCjujwoFrB/US5vYrqKFaOngqA0FtxzAslOv7ahdf6573msK2UMJ8bN
         dS8w==
X-Forwarded-Encrypted: i=1; AFNElJ/a6m/++HDPku1S18NOLKEoRW/kCNLFa88YgPUhVOG0GuZeTcTiN+Tjt9YredYsZewMQhe0RilmtbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwKQIGranUJStwazeOcTmlmyAjiqNUA52aqtDjMxg4Xhf0ZQl
	KyQOh4OrAmJZ4qk2hILY+KSskhf4yaEtG2wieJxCkdNKx7MYo9ocIPmyB3RI57U3Y/k=
X-Gm-Gg: AfdE7clN2xAazp9JDeSRSXFsdf/3bbjp01fFRWWMbLbSQzBNMZ3oxWD+nuHN7uyR+w0
	ue+io9+NTBoIrNyKk7zbp5CpHqeuOMkEF1sEfloS0z1PxPtlscROS6kgaTY+UYmMUGdcJ/XQCWW
	7lghH1SCtC+xYgjm79c9VpCjsMA/lTq/O6+I1hwnmpkTuK/JEXxUYHPO9ukjq8OSTD1mZD2ZBEi
	6SR/Sc9CgbdU7yqivGqGIGyVXjxlScrjylQWNly8KQlcOoJLovJW2PeNTm/eFW+aITi3lNrjUrr
	BbWd7XUyETVFQ2x+rX5ale1jyq7frbjXWMud+HV3YCzd6nTVKDqkYT9EZooD34wIg24r8XVINA5
	kLXk2sfkl+bpJqzXYstvD0n1kXCpWR+UylwLaj5P3ciREVtnIG+dfibIK8bBpk1Q46GBfkdQvTA
	soBJ7+w9+w/3Xp069jhD5vY5mNDQr205ZOvvcMRu5JvQgf0hlspZWLLTCsRZtOgqc=
X-Received: by 2002:a05:6871:820a:b0:43b:58a4:cc33 with SMTP id 586e51a60fabf-451065bccf8mr348850fac.22.1783347024487;
        Mon, 06 Jul 2026 07:10:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a38a:a0af:ed1d:5c77? ([2600:8803:e7e4:500:a38a:a0af:ed1d:5c77])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb6691d1sm10542741fac.17.2026.07.06.07.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 07:10:22 -0700 (PDT)
Message-ID: <2d84950f-c56a-48f5-ab7c-c7b7ccb3b28d@baylibre.com>
Date: Mon, 6 Jul 2026 09:10:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] iio: frequency: ad9910: add RAM mode support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-12-79125ffbe430@analog.com>
 <20260703040544.08a8ea5e@jic23-huawei> <ake_YWfvVC9RQ3wu@nsa>
 <1493eed5-5bb8-4a2c-8f2d-8b4bc5dde157@baylibre.com> <akt3i_YxG-jF3IdJ@nsa>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <akt3i_YxG-jF3IdJ@nsa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/6/26 4:47 AM, Nuno Sá wrote:
> On Sat, Jul 04, 2026 at 11:50:35AM -0500, David Lechner wrote:
>> On 7/3/26 9:09 AM, Nuno Sá wrote:
>>> On Fri, Jul 03, 2026 at 04:05:44AM +0100, Jonathan Cameron wrote:
>>>> On Thu, 18 Jun 2026 14:27:28 +0100
>>>> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
>>>>
>>>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>>>>>

..

>>>>> +static inline void ad9910_debugfs_init(struct ad9910_state *st,
>>>>> +				       struct iio_dev *indio_dev)
>>>>> +{
>>>>> +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
>>>>> +	char buf[64];
>>>>> +
>>>>> +	/*
>>>>> +	 * symlinks are created here so iio userspace tools can refer to them
>>>>> +	 * as debug attributes.
>>>>
>>>> Maybe worth a reference to appropriate ABI doc here (even if it is introduced
>>>> in a later patch)
>>>
>>> I'm not so sure about these links. I mean, I definitely agree we should
>>> make it easy for userspace tools like libiio to be able to handle
>>> these kind of attributes but using debugfs is questionable to me. Pretty
>>> much because this is not a debug thing. It is a real setting for the
>>> driver so ideally we would be able to control it (using the existent
>>> tools) without enforcing one to mount debugfs (I know that most of the
>>> times it's always mounted but still feels wrong to tie "real
>>> functionality" to debugfs). 
>>>
>>> Having said the above, some suggestions:
>>>
>>> 1. Make the iio_dev the parent so that the attr name is just "ram" and
>>> it will be a subdir /sys/bus/iio/iio:deviceN/ram/.
>>> 2. Propose a new helper for the firmware_loader code so we can get
>>> struct device from struct fw_upload then we can easily create a sysfs
>>> symlink.
>>> 3. Name the attr as dev_name(iio_dev):attr so that it becomes
>>> iio:deviceN:attr_name.
>>>
>>> Now that I think about it, 2. does not make much sense when compared to
>>> 1. And If I'm not missing anything both 1. and 3. can be sanely parsable
>>> from userspace (being 3. maybe a bit more reliable). And yes, both require
>>> user space tools (in this case libiio) to support a new type of
>>> attribute (firmware) but that is another problem.
>>
>> I would say that udev should be used to find the firmware device from
>> userspace rather than creating symlinks. And you probably don't even
>> need udev if you already have the `iio-device:<ID>` value. The path
> 
> Just one note. If you mean <ID> as the attr name the above will fail for
> multiple instances of the same device. That's is why a proposed
> dev_name(iio_dev) which I think it should reliable be iio:deviceN. 

My <ID> is the same as your N. It looks like I just had a typo of
an extra : in there.

> 
> I guess N might change so anyone hardcoding it might have surprises. But

That is why I mentioned udev.

> properly done and we have a sane way to match the above with anything on
> /sys/class/firmware/iio:deviceN:<attr>/
> 
>> is always going to be `/sys/class/firmware/iio-device:<ID>:ram/`. It
>> seems like the same amount of work for usespace to computer the path
>> either way, so might as well keep it simple and leave out the symlink
>> stuff.
> 
> Yes, at least for libiio, `iio:deviceN` is already what we call the
> device ID so we can match fw attrs against it and everything after the
> last ':' is treated as the attr_name. 
> 
> We just need to keep in mind that if a second user of this stuff pops
> up, we should add a new helper to enforce the ABI.
> 
> - Nuno Sá
>>
>>>
>>> - Nuno Sá
>>>>
>>>>> +	 */
>>>>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/loading", st->ram_fwu_name);
>>>>> +	debugfs_create_symlink("ram_loading", d, buf);
>>>>> +
>>>>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/data", st->ram_fwu_name);
>>>>> +	debugfs_create_symlink("ram_data", d, buf);
>>>>> +}
>>>>> +
