Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792907577;
	b=VTpT0/z5csldsU54bmfbZ+5PY6UTRtsLGf6BuBwaxJ17FhRKEx4mhZ6r/PT8QORtBmpw
	 zpBi6xKowua8J44seoJ8M8qOYXuXyETQEDre20JFn+lVxNk5TxJHkh2yoH3rwnofgNCaq
	 dWdaA6Aj5tgRqcb1Q29CPWGyEY0SyCQA+l2ZoLxddIbptATasV3Z4qGFKIGnwtIJY6xOm
	 UvKBPdKAlnX2OpIFNpOO0LrHdsrzl855y1Z1dXhb9XPyuMdrKb90Vhl1KAoRD6iC+OM19
	 ifUI/EfCTCaamvLub73SIR4Ra7+GDI7ScsaEBlhjqGW+NjAGsAyTtgpL1QmKnL1g7ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4rTPGcAaNq6kazh+6sK1ZLKNoqk8Ps4YF4dR/5hZ7P0=;
	b=YSFJUYTNccN6QwJ4NQxaW9v7WHr1yHuNXEuqRb3186bd+r+jr5xBoPdsaqH5sLHLvVIq
	 rbnFwDch00WHpVoRwLtu/uCt7vOnapzC/7Zz1xIGtoVMuJtJn8WSnrkg+i3ggUQYtQvJ7
	 BKXr6CIis8VKJQ74oGVEgO2nkdR9utT6GQmjgUSB2or/MxoMc97lNDnB1V+yi4FwA2LxB
	 pYyDglDgy+RlfI8PjE4Wa15Jw/BY1DDl8ygXXKq8Pd/EdMhrnWsm0lmEDVsFzh+pGufen
	 NU7+kRkDHAiFLFrJszJpInZg8JsTLfi9kG9gWcZweKax4vV8wFw19EiYA6NXgVQzukQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="B/8LQAMh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4CD60A2603
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 05:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF4CD60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B/8LQAMh
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc365db987so1495735137.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 22:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792907576; cv=none;
        d=google.com; s=arc-20260327;
        b=LJYmKSmW/t5UUIEr2GBEZJfgR7TUEkdL5o7pXrGVVndCrj9/lNZ5+rPBUqRn0gSBEo
         66e8NMquKDCY21B32kJ7wwUFB9/8ktcbxy+YthB8NDT1yNbMyejbmRlMlSf8TCjfsiLr
         01SuC/aw9UwOtgNt5YhwAoqF87MJZx+Bgh+qPYQspDCIiapBUyXFKM0+uN3NPP3H7V4F
         /dfsFKUXQo6WMFOsqsYXqqThPRMbEYGyfimc7s5MUD62EsF7et3W4WqUPLyPWO54M0+m
         k5QUe78fAqnoMh+fE3MXc0zBFMog0lkm/EZhLmWWrZKU1DUizPbt7k0+pzyAPuOQ4ZCv
         NsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=4rTPGcAaNq6kazh+6sK1ZLKNoqk8Ps4YF4dR/5hZ7P0=;
        fh=G4kZwgR4Gk6QqQHQSUK4I6Krn+i5f48eP6oMjn2Ogeg=;
        b=DBTIDJtLIJ0Xdb3BLER5qIog698y2qWwehKiBS7HnI+/27nL+9q+Y9z4IdK2v9mbrf
         GVHJJb38Qw/caGdqkn8Y3z7QoS0JIM5h4f6buEGVizPWQCMcgl4Om+6e9wVP/LACHi1A
         4DvCshRJnFMkV7K9u/nsPge5vcu0jkCJnQDu4JxlXfS4gxvDvVGnb4sg3UMHMYCoJ7NC
         hzL3DBFOWtuXsybvxVoRZA8kWAflIgTZBKwVQVcJPakTC1/6dMpe8nylX+sjpKTHaHOG
         i3057fsV9QKBdaCqiMt6Ec3MXVVmw739eSh4fx3M/whF8wQRVbAICWM3Ze+4967llVWv
         dgbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792907576; x=1793512376; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rTPGcAaNq6kazh+6sK1ZLKNoqk8Ps4YF4dR/5hZ7P0=;
        b=B/8LQAMhw/nNihjwcvbGlGYQK6KF+IWGos9cPCJLbYNLDRTab1lhAWpjp8Uk+AlLLG
         pCdy0hUqgMuux6eS3j3BJadlFlgNCvSX1zoTU4RGvkJtr5SPLOWo5hs91o8G7ASeoY7M
         Vb2ARlgoyRpGdfdg8DM6Gs3a8JNLwUyjtD6HVc8y801f8eYbNL5NADZzqatbgVTLi6Or
         tGhnXPbCPDYUEbq0g3VOpR4ATvOquqlkp87cl55qpA3eRFWpQVv6lGBViKuPoti57af+
         4yXtBC9j/xPdHhmC4NGh2VPcVGvYwF5D9Mj+E1AaQPHBwsepdDASFyDQcDDxMDVv/uZM
         4MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792907576; x=1793512376;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4rTPGcAaNq6kazh+6sK1ZLKNoqk8Ps4YF4dR/5hZ7P0=;
        b=cdL6pJagN6LKlLDSdXQTI46FcdsrTUm8fwhQM3YmKmzVQn8hm9KCyolMMwuSq+s51m
         LvgSsPXGp8VWiNzbHWSFDpPkHJYTuKVWL9xGBLPOrusl/9gituh8GT00w/VNN5p5Bx8O
         uFpPK7XaaPV5trqnifwlNuJLhQBeb6QqXCk4nf/U+ig13utHSbrEtZgSNKMJWIisRCcz
         S11tHu5l9gNIsd+fXujaI+Vu3qr2kSYzOfWLrMB/tTGizsmlpB/SW54+jJT/5cJDsQmG
         zmx1Wwm+41kV4vSsGMAE7mMD0xmCYzLUvVi6wIdn8sOACLcsR/8tVf8xVKEQU5FNC0eM
         p96w==
X-Forwarded-Encrypted: i=1; AKwUvBxrkRZyADxsGBk3mWdx+YPHzLqKVGnQSoOQVJUX11P84Rz1HCLeBpVqZDbMnXeZfU49JsPWhLMqbuc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzL4LPXggoOD5EHksM/xYGEoYA9aOG/3sIrrRi33fJiCKrs/ry
	Y0JdqKyQGRMmovSm4UFCsTb28lT+P6qlt58OglKiXKEzhBxPYQUUFe4RqMKhZMBc9zesr4P8Y2y
	mDt42GZ+fIfuyXLebtyj0iNEJtqLEZn8=
X-Gm-Gg: AYBFou2WB+QYHmJq9qhUqr8j99kpV62DvF01UhdvSD9Q46yTeWPwuh1zv8BMz0mqzjR
	Vnk1np36TnTQDoHSick7crw9HSTiB/UVYrPi2BFOJqu2evwIehQpST0d5JUmd5c5NLuqAq90qRW
	4usxFkVQraJ36jZJGqUnuonvFQTpbS3xb2s/cfsn6Ia6IYibU6h6fI5aTEQ0Kubl4YhfzWPUUX4
	vEZM6J4APkgFzSecdV5seV7zeCto4VajwNV7A1wOFLLCyZ7vWxo8Fcduyq7FhhMv07+Z4cyFsGW
	o/wsMG5vCEfWC2S6ygIVg7Tg2kg5Uooasp4J02bUu35o8weVmzGzcDjwU3AS++eELzBYzjhAm6n
	IJsOWS02wLDdn4fCML+AiIm/oiEesOaqp46s=
X-Received: by 2002:a05:6102:50a5:b0:7cb:288a:b678 with SMTP id
 ada2fe7eead31-7ce5cd65bc3mr1049568137.19.1792907575694; Sat, 24 Oct 2026
 22:52:55 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 24 Oct 2026 22:52:55 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 24 Oct 2026 22:40:10 -0700
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: berringtoni36@gmail.com
In-Reply-To: <20261024034931.5d954108@jic23-hlaptop>
References: <20261018-adxl345-event-state-v3-1@gmail.com> <20261019-adxl345-event-v4-1@gmail.com>
 <20261024034931.5d954108@jic23-hlaptop>
Date: Sat, 24 Oct 2026 22:52:55 -0700
X-Gm-Features: AclHuK_Q4KiCOyF_uPPIzJpNKQf2tZ1364Q-CZyBBIUJeS5cafrfa8v9x-hGR54
Message-ID: <CAF2O-sO_Ce35L_7KddzHCywoxZ-ng4AeRLPfEBnMJJR9KAPZXQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: accel: adxl345: separate event state from query errors
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lothar Rubusch <l.rubusch@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thank you for applying both ADXL345 fixes. Noted on the threading:
I'll send each future revision as a new email thread.

Best regards,
Wenqiang

On Sat, 24 Oct 2026 03:49:31 +0100, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 19 Oct 2026 21:05:20 +0800
> Wenqiang Zhao via B4 Relay <devnull+berringtoni36.gmail.com@kernel.org> wrote:
>
> > From: Wenqiang Zhao <berringtoni36@gmail.com>
> >
> > The activity/inactivity query helpers return either a boolean result or a
> > negative regmap error. adxl345_read_mag_config() converts the latter to 1
> > with !!, reporting a failed read as an enabled event. The disable path
> > also turns a coupling query error into a successful write.
> >
> > Return query status separately from the boolean result by passing bool
> > output parameters to both helpers. Rename them from is_* to get_* and
> > update the event read, disable and link-bit callers to check the status
> > before using the result. Preserve the successful coupling-mismatch
> > no-op when disabling an event.
> >
> > Fixes: 66a1af6d8a63 ("iio: accel: adxl345: add activity event feature")
> > Fixes: 31f7679bb69a ("iio: accel: adxl345: add coupling detection for activity/inactivity")
> > Assisted-by: LLM
> > Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
> For future patches, please don't reply to an existing thread with a new version.
> It can cause trouble for tooling and generally makes them harder to spot.
> New email thread for each version.
>
> This seems fine to me, so applied. I'm not rushing this one in though
> as it doesn't feel very urgent so applied to the testing branch of iio.git.
>
> Thanks,
>
> Jonathan
