Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B72BDC0B
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059200; cv=pass; b=ATbYgV30okbz77MC7gz+6FIPVB5/BQYNwFfUcDZL89nk+ob4AhP/K7vDPKjdDZ2O+Tjk2VpgyHhmpwMUffTPFXReLboJEetMsE2c5MOI9S92zKHzLY/fmLWhm6Kj6MafUvx1y1cDmEI1cLQUSeLNMQHFJRcvt9OTxgKNSFdQy0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059200; c=relaxed/simple;
	bh=532+dLG2bbDU5qhM1SXwnloFiDTZfwwoA/4+UkT/VQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTfWF8oqDKoSVO64ovBWEeEq7tUHEhQfLysJoar1eBRa+aY/2Zavsyl1FuFrJFDEq93h4PJGVFdC9XQya4FpaMIvgW+Etv8UZ0ysRQW1yl1eTfm1jVUJBkVd2ZVY+cCQ9lzcTyLFNbkdT7n5GURpnXY51/fqsg2kkO4nMWcYm1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6cudlLX; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6cudlLX"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304545f5206so10699197eec.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780059198; cv=none;
        d=google.com; s=arc-20240605;
        b=izJjrStPEMPku+tsGcdkTODDzhGbxI1LV4PUv1BMZJHzQlr/TQX6DUnwYtMW0ta1Db
         3UyscGtWoH8+uz6N7yGdEJT+mtBYNPT7cu1A+XeTIn9C3F6yRhBTZxnS8xtQtKXVWkwe
         66XRsk5PObm012iHUXBD5+apKfAGj5cZsM6YAGWnQwUZYGVYcCO41a0T32XleARThzc/
         V4IXCRG4Ppf5eVIY97n2Ui4l3CIqDNr9IGxadp/89Tu8dytTSmfCM23+FDr6rWxdm3zg
         lK2TpZAJl+B/XAN9sK15kcikIgD8oC6dUpankhX5zLuSizd3bsuHWycFPjKWdHEk77JS
         sNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4hkrvbEDQ7S/ccYzMc9b/sSg1UxvqgRfRv2D5+QoUYc=;
        fh=UBjF/oaYi4vC6OARkco+8hEEXBrCV+v5SUUTBWTLU8U=;
        b=AVR6rFlg+jYDmOJxTaoJaU/+MRWczleeCZF/RhJylYdLAINRzIimqi4bVfEE/bbB4F
         /zoiijR0NSXcYeGgBu9eCpYQ0s3LQfkf2eK3eZvDNh3guE2LnS4yOsrW9Asswb3BGugF
         bVdRjtwFTH+r5zAV2Bnk6BptlidLNJ1HqNI1JIpGKmzaa67f4jU1hukr6t3LyhNmwr7n
         o0dS4BySfNguCIJcZl4sfCjNdZgf3TAPC7sbZ0OGixhqQWmmy8tVrmWSi1EZWG3BR2NG
         1p13ZJUpx/7U4E10AQXNzDX/R0a5TkyfQF/f/xjMcsVYhbHdxjRC9Qkgl1l9m36EzF98
         uK1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780059198; x=1780663998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4hkrvbEDQ7S/ccYzMc9b/sSg1UxvqgRfRv2D5+QoUYc=;
        b=U6cudlLXv2JjG82mE+rJwRAbLqPeJT/u33TZ4rosOyMQQDj/xMAo3F+Ad/TpaEYh9p
         rLH83ElBwJ1jJc/DPqQ1NMvPpyxdzWNcPQ62ch/dGQXN40H/LWD25PHa0a33r7Vys8I2
         cwK6GgLtZiN821PCXVXi+HxZ11SPlverzmn6jhaGu1F4m40FCYM11Q1kPJOewmUlcCLP
         s07OsPWJMrPazFX1yFpEERLB6cRrMT+HG/32dyFGssxK39WaD87nK6GERO5sjH6Ber0p
         nKshgGGp3HnQ1/OMckRkbhITshCgTHj1Kbqfws2aNnZXcDFfRKzQNn0tWAD+4rHO9rIb
         oDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780059198; x=1780663998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hkrvbEDQ7S/ccYzMc9b/sSg1UxvqgRfRv2D5+QoUYc=;
        b=q0qNOXuR+YAVeei4afPXItMwMRXClLPRmW7+v5u4nYkoOmrcTKzji+XFBuXz9bPozE
         CdAHV7nSu1m5NUgho9viQp3e5ep07ypZQbGWzdDW+TULlGJ7m3XC1XTXCfUO0Rpjrmbk
         rNx27ihXotKh5eYPWcgAPo/DHss0VevdNnuyzi3Y0hve8kPTZdG+0zs2iWugwBhQ3jD0
         nA8OLFkP2vy8IoU6dkl4vTagxVu2Pf9DEIGHptq6HcsdcPSOTPPdJ2JgorDXp8q7c1Z2
         76WPyKMTAEPeEcQYnWb1Xec8W5j39St6IDZaRLA+Mm1cINpcrHTymMSKF0qwYIv7xNKf
         qzAw==
X-Gm-Message-State: AOJu0YxvI9BVV0RQa2h7ooNmsU0DvIMZfnipaovz7sCDbl0GoD95Owtt
	w5vLopjFEeJ4HllDirXI8viY5t2zjrvpHfkQdq1Oc3bRamDf6pQP8WRRXcVCqxhjt0mgoNkJOuZ
	Tn1Ipkg/sqvHarubXmYorTqnquGKW+FI=
X-Gm-Gg: Acq92OFIj9uQ30o+R8r0WMB2aYLA0XrcWBZcyS5CM8fKeWH0BDWk8yAUrecMivlCW+4
	p8fzicSRQUO5M8mxMEJO28dvgiP8Wex8/PjgQ2FLze2wFELNv0hU83IL60aoTkdHzaaP6PiNvoV
	EgaMqxtVJUb96l5broBSpa71XzJZK4eyrjxvRICdQGIs4T/VZw+LrCHuCkl8/+EDd9hoXVnRlwF
	5vSa2S8rhTOrMScwULIJ3dGN3cx1SkjadDpLUQLUEQScfDEyVUrWaC7ERAxyHYT+XfBc0sZWFi+
	lWNs9Ew18Pr6NZ4z7ZTk6cTNiOgt4sLqJI21EoCVUIN6bAcoHnOwEcmdwoTgxSzRE1pkLVaw+NI
	at46U4A==
X-Received: by 2002:a05:7300:2316:b0:303:a1af:5042 with SMTP id
 5a478bee46e88-304eacd38acmr1536564eec.0.1780059198197; Fri, 29 May 2026
 05:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
 <20260524085312.15369-4-kimjinseob88@gmail.com> <20260528144853.354a71e7@jic23-huawei>
 <CALMSew+wUH1H-2MTtexCFgyD4Y+upFuSfFzTWBn3VGN6CWYFNQ@mail.gmail.com>
In-Reply-To: <CALMSew+wUH1H-2MTtexCFgyD4Y+upFuSfFzTWBn3VGN6CWYFNQ@mail.gmail.com>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Fri, 29 May 2026 21:53:06 +0900
X-Gm-Features: AVHnY4IPPhh4OolSzIGZ_CRDIofNCpXhPUVz-GCUtgihrVwln8rbJd6WVtVvqI4
Message-ID: <CALMSewJk7Kt-o99MJVFLEHbLwRqcnJ81XHbrfs3dy8VFgssTsQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/7] iio: osf: add protocol v0 decoding
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry, resending in plain text.

On Thu, May 28, 2026 at 10:49:00PM +0100, Jonathan Cameron wrote:
> https://sashiko.dev/#/patchset/20260524085312.15369-1-kimjinseob88%40gmail.com
> Has some perhaps useful feedback. Please make sure to either exclude
> them as false positives or address for next version.
>
> Quite a bit of the feedback in here is about which checks are actually
> useful. Normal kernel practice is assume we didn't shoot outselves in the
> foot but hardware and userspace may have done. So we defend only against
> things in their control.

Addressed in RFC v3.

I reworked the decoder to focus validation on device-controlled fields. The
v3 decoder now validates sensor_type, sample_format, channel_count, reserved
fields, and payload length overflow cases.

I also removed unnecessary internal-only caller checks where the call path
already guarantees the arguments, while keeping protocol and stream boundary
checks.

> Similar on whether this defensive code makes sense

Addressed in RFC v3. I removed the remaining internal-only defensive checks
where the caller already guarantees valid arguments.

> I guess it might change in future, but for now why not make samples an s32 *

For the variable sample data I kept the wire-format decoding explicit because
the payload is little-endian data from the device and may not be naturally
aligned. The v3 code validates the format and channel count before the sample
data is consumed.

> Similar sanity check questions.
>
> If that happens seems like something went very wrong elsewhere so
> seems unlikely defense makes sense here.

Addressed in RFC v3. I trimmed the redundant internal consistency checks and
kept the checks that validate frame and payload data received from the device.

> This one does belong in here.

Kept in RFC v3. Payload length validation remains part of the decoder.

> This check is fine as picks up on bad hardware, but why keep
> the value of reserved?

Addressed in RFC v3. Reserved fields are now validate-only. The decoder checks
them for protocol compliance but does not keep them in the decoded driver
structures.

> I'm not sure if there is a way to get here with any of those failing.
> Generally for kernel code we defend against this sort of thing at higher levels.
>
> Same applies to all this parser.
>
> Likewise, I'd expect this to only be called on one that exists. This
> defensive stuff costs us in complexity so only do it if needed. Do however
> defend against values that are coming from the device where possible to
> ensure they are consistent.

Addressed in RFC v3. I removed unnecessary internal-only checks and kept the
validation for values that come from the device.

> Why keep it?

Addressed in RFC v3. Reserved values are no longer stored after validation.

> I think you are setting them all, so would be neater as a designated
> inializer:
>         *entry = (struct osf_capbility_entry) {
>                 .sensor_type = get_unaligned_le16(payload),
>                 .sensor_index = get_unaligned_le16(payload + 2),
>         };
>
> Same applies to some of the other structures filled in here.

Addressed in RFC v3 where it made the code clearer. I also reduced the amount
of field-by-field copying where the decoded data did not need to be retained.

> We don't need to match types with original data so
> nice to use the named enums if possible.  Will need
> to check limits though when decoding.

Addressed in RFC v3 by validating decoded values before accepting them from
the device. The decoder now rejects unsupported sensor_type, sample_format, and
channel_count combinations.

> Compared to capabilities this one seems trickier for
> types given it's variable size. Still nice to use something
> that indicates the type if we can.

For the variable sample data I kept the wire-format decoding explicit because
the payload is little-endian data from the device and may not be naturally
aligned.

> Are these not struct osf_capability_entry?
> If they are then use that not a u8.
>
> I'd not bother with a const marking.
> With that type fixed you should be able to use
> __counted_by_ptr(capability_count)  to make that relationship
> clear.

I reviewed this while preparing RFC v3. The capability payload is still decoded
from the wire format, but v3 now validates the capability entry contents more
strictly and avoids keeping reserved fields after validation.

Thanks,

Jinseob
