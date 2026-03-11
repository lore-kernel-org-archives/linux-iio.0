Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80F38DD3
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773187908; cv=none; b=uZ8DGDXtY5+CH7CGovGKL3KD7aE1M26Cikjnr5O0Of3Cax2oJWnUQ3MjWcv2ORoluO9ifgjvAWMn9UuETBABu/NbvwhbRuDhGQyh8pTdlCVuy7nPIEzF4olixzwlkkGRhsFFduYhRfWXR4LzD46Bbj9R/SnsX3GzGsDzzlotkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773187908; c=relaxed/simple;
	bh=P3lEy5gIkhZ3O6GB/4pR9gWhPNMout6x33dBMMGTqnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kz0fP9AQvDw70nYYExYwj5uMYX64qPo7pWsCXoPMV/T2QQr7ananS7wtbqJP4d7TWwXVIL20+CEhD3dfq6fpnU427o3amhT5ISxSFz9NjFevS4RKKUZZtQ+R9sKYxymjeHw/42csY5XENvvezPv9R+XAPmipsiRe9BVBenAFenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y/qXzXUk; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y/qXzXUk"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so12571187a34.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773187905; x=1773792705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/g9x/WAltqKnAS6kgiR1qo0fBhygP8SG/QvklfILzc=;
        b=y/qXzXUk69fxfYkmTeImwa+hj4O/vGBPkAt+DNTFcOLgLY+ACHSB+ypg7s2Gq994kZ
         7hm2qsueBPtYoM2ZM0Kf9Ncd2AFnAdxm519kuYX0gs1ukgD+qRY7N9O1F2AlhhVBVtLP
         sWRrh8oW1dXSqr8VW5cNdCAgxnGNdokwp0iviYDlpl8/DWXIcnLiGxKtGMdIj5gWJTs6
         0oObGrTRYZDy6JFNDiHF/E1HRhzJvWQrfpBxKqUQqVndkwjtQD0Kbm0rRBKYqX9i4tVh
         JyRgLZlQBXMGgIAVwRL2eLAuGrUCh4d1nY2RxsCABLW7tAXen/c02DKwSWStrNzPEt2u
         ALJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773187905; x=1773792705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/g9x/WAltqKnAS6kgiR1qo0fBhygP8SG/QvklfILzc=;
        b=aMWZT9/GUD+i9vJGprckXzn+MUrSzLt4hCIHeHzNfx5TNfCxvBWh65/RkjcCQtqXFC
         CJvC5uhehCAmh6++4KIKtB6Oh9hGafndPFw+6IP5i3PH2V+9OHQ4VX1CSR2FbcAmVNXi
         rDp39mh2iwzeFDWGX6hp9zzr5xSOszxzW5y3lv051sHycqDycxJqxGh5fJkGoNy15rHj
         wWh1s4HPYpa/X4Xc6WskPwC5jEkY5DO5Lv6Ntb5mVbWsJIROTCnhpUQjn+e/7F7/dm7D
         ks5tWa3Ivwczn7CkwbtiDr0aoo3n+E7hsTtJIlFNWnOcnBbRNKOZfuxkf4P1bVQHBKT8
         O+LA==
X-Forwarded-Encrypted: i=1; AJvYcCUWEsYtBkiQFXjU8ttXb/FU2Au/eyzayanAg4V54+GHYVsyW9QDwL5lw1NAn4IfRsMDvdrg3bSVNZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/2X7rOFu4TIvtOdy6AU+8tmPSyFyyRMUYlPEk47E9LqLljey
	c52d5L21vSmyvmijv0O252p7B5Lx3j9MYNUcwyrAr77DJTeclmx148vetmnXZ/uXG0M=
X-Gm-Gg: ATEYQzy5cYnOsihGs+aY2XC2dZdwP9WEHWgf88JhzRSrbZfWgbTqShL2XOdGMS+5ONn
	JOaPBn9WlX6lqKOKj6yUcotUn2RoL7UCbAY+qQgeD7Jtt5CG3eMwUpYl7nNiii7mmngQN7FA2xh
	ODyPLhRcOmTeVoL/4aei+J1Bw0awJ0mtD/TAEUguWC9CKsEBSwG87Y9EihgE2qDtFMziDd7Q+2p
	VQ8Qu03RNk/F8KTTV/stkLV04CD6wqsvYIaUaTID/dHrl/pd6qk6tS9z4/20LmbxRotVU0EmHCi
	D3h6r1IsqsSWKEu0RN8r2XhiruNkVodvYEnn52+hbaUfIHAu1dXLxjkdPr5225OQWQjeW5qRa6V
	hE0Bmu3hwjhAHEN1smUhM8K+G4rSyJ7A4J/V8qhBBkWhX5y61pIQtvVq1qQ4zPlmGgFYIeo5y8r
	5UPQvrcpSOTDuGR6L8wOXs7sFcM3bYhd++cCA8ylwa4WklEcSna59VKAOameWk63hmc5+0sSWW1
	Q==
X-Received: by 2002:a05:6830:264b:b0:7d7:382f:f00f with SMTP id 46e09a7af769-7d76a73d752mr520754a34.31.1773187905339;
        Tue, 10 Mar 2026 17:11:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03? ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aebc9d3sm492155a34.24.2026.03.10.17.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 17:11:44 -0700 (PDT)
Message-ID: <b1187027-3ddd-43bc-a773-8b5d794e04fc@baylibre.com>
Date: Tue, 10 Mar 2026 19:11:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/8] iio: frequency: ad9910: add RAM mode support
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-6-3b264aa48a10@analog.com>
 <20260301133153.7f2f8501@jic23-huawei> <20260307140735.5ec2e608@jic23-huawei>
 <bxcybwaz3am7nrrfcjuvkbbe7yp4vwcxwwh4dafaj5dsy622s7@m4vdam6tyaht>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <bxcybwaz3am7nrrfcjuvkbbe7yp4vwcxwwh4dafaj5dsy622s7@m4vdam6tyaht>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 12:40 PM, Rodrigo Alencar wrote:
> On 26/03/07 02:07PM, Jonathan Cameron wrote:
>> On Sun, 1 Mar 2026 13:31:53 +0000
>> Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>> On Fri, 20 Feb 2026 16:46:10 +0000
>>> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
>>>
>>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>>>>
>>>> Add RAM channel with support for profile-based control. This includes:
>>>> - RAM data loading via binary sysfs attribute (ram_data);  
>>>
>>> I'm not sure that's a long term viable path.  We either need
>>> to figure out how to do it as firmware file load, or via an output buffer.
>>>
>>> Firmware load would probably be too static and I'm not sure quite
>>> how we map these to IIO output buffers.
>>
>> We would have to carry it for ever which is very much not ideal.
>> The firmware approach has the same issue, but can be thought of
>> as defaults at boot time forever.  If no defaults then we use whatever
>> we come up with as the long term solution.
> 
> I was thinking about the firmware approach:
> - Normally a driver would request the firmware during probe and the
>   filename would be pre-defined.
> - Less statically, It could have an attribute that once written, it would
>   request the RAM contents (e.g. under /lib/firmware/ad9910_ram.bin).
>   It could be the enable attribute itself (but that would not be effective
>   when the binary would not change), or a separate one (e.g. destination),
>   or a new one (e.g. load_en)

Have you looked at firmware_upload_register()? It looks like it provides
something along these lines.

> - Alternatively  we can also have an attribute (like 'filename') that once written,
>   loads a firmware file under /lib/firmware/<value-of-filename>.bin 
> 
> I am currently using libiio to write the sysfs binary attribute. Thus,
> the downside of the firmware approach is that I would have to use something
> else when changing a firmware file remotely (as libiio would not support this).
>  
> Also, the buffer approach has its problems, mostly because triggered buffers
> are not really designed for multi-buffer support, even though it could work
> along side the DMA engine one (that I am using with the parallel port).
> Additionally, userspace tools are not yet ready for multi-buffer support.
> Also, an IIO buffer might give a sense of data streaming capabilities,
> not a one-shot load that I need here.
> 

