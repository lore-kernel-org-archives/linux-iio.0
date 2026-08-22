Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D963803CF
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787386655; cv=none; b=NBayANEHfoCxK41XHiIPDd+PXjkQ0u2qlUO6o0Bjb7ng64HrF0eBiapYwxWGQXJzMELy7m4ehs87Ej0bZDrPD/iPyh4lGfFT922AlgDvWHiFiA+iCOAXKSQkfZfjDVZRM6cmbTgJqH+xPymmlk/8DU7A600e/jfN4I3LCQo91A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787386655; c=relaxed/simple;
	bh=UyKxg/OrY1NTQJ/hzfVkpY38iioftx2ea0uczqSQn+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WihWePTcp7Qr8oObvX/IxS8uwsYHnIMrK16iEvZfxmXnoVxurraMAXTs2V9hBw3wW5vio2oeEa27xbNJWIhuNNgZsfb+eYxv753i6+Q+AH/xxNiwOEMvtxhyOErg0JkOfzJJJ4HkgRUiRg0Yj+mJk2bKRaeYujV5nEraTHKxDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwBY8j5B; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwBY8j5B"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20e70a0962so269239866b.2
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787386652; x=1787991452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZBoB9ptiqxQTzqJj9v8b4ETyoimSYERkDLiGVDY6vjU=;
        b=dwBY8j5BxBTmRkbbkXGvDFL6b62z/KZfLwqlNLiQkmrpNyR+HaIo1ff7gOiRD9IiIh
         +3JphImZuYUReims+sbFIPi0gFLpmj47C5C2IYwngKx/jQx0g+fgeaxJamIYOClwx3M3
         RygezbS//DwiDSpVYXBJdcvHB/T15XdKUk0C24cJCDw/w75fBcAy4TozqxiErhgG8Nug
         M0XXg94G3/GvhqqDnGecJZNsXZAnNbN5dJGYH4RCKXQf9XnPiVf1hIVz7xboIInOMbHO
         Mn6T3GuSrnsn89HtFEbww1GWU53dQj2pWJsePXoeoL8CX+YhyNtviCDZ8c0yo4wypVhF
         9L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787386652; x=1787991452;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBoB9ptiqxQTzqJj9v8b4ETyoimSYERkDLiGVDY6vjU=;
        b=Ft2pLkpRlGO6fMiaUb7rYgKnRt1ngSjCW4Z1lU1WiLBHpVg1RgXXrSV5DXFdin07mC
         2RrZjRlAuuaelz1D1wOqrnZtc/+aiHsR3nhrm7dixGJOO+90XrMlZyppJ/gQeCL8hc7l
         o+Eg8ARtD4SFNTA0LZMgE3g5r4Pk7F9m6E0ClJ0Ub6h0M/6MEJREfvm/llvMFbNep98N
         fqRQVdIApr8ld82GpMWh+Gf9YAiHUXACRVOC9ESR1eDPHovkkiU+aPetlw6Vzb5RqP/3
         EJR0kkc3einIDIjLWiri0g5YHzpYyVfC5oY+MeUlNSDXMvX29voRbYP1HrLsYCkHOl7O
         uAVQ==
X-Gm-Message-State: AFuF++k3h05781rioKCAByTzJih35CTSHnJag82qGglfk7EPsJl7hBD/
	zlbWb6BZKObP3py09IioACE0DfjcyUSVyxt7UwxF2KwfU1qm71N1RGmt
X-Gm-Gg: AR+sD13UQbPOyk4GJ0sWzcQe4L19cEjcM2A0Yg+XoFT/1aTjnlUnw/wOXNJLmiEoeAS
	vomfKQDzgN2s0Jo7Y1dvP5LRQZB/d2s7tGkhCwFH5cduL7EQAMwofQRVdLfeFC3Jm0HDdjguw8T
	M4YPx1ubhdGsP5PTrbUXExY5T1LsLqQKBi8MoTaz5DBPwoc0DA+7iMykJsGpEI6qaDCTURaNk81
	rtiiTiuIFG/1Gz4oF9mF1HN/IiNOp7Rs0HKRJ6zBwMYxW3O4v50eABRYjuTZcRg/JifeABigTSV
	egM0vylebpM/YwFOKHkKFdycPUwyJB9Fp+dpVQZF+X32IKIFrw1GHRf05FO71ZH5Bz9y4pS/GG8
	ztMNCRaHA3iGwTuApRRkv82NI3ZqH2lKRiBysGbjc4XdrlcUNDPw7/8t5Br3V0yPwWzu3c9yKqg
	duhziS90xgbhH9Prw5kwDDBXHybB5uBH5Jkqu8Hx7a4wuT5RRO0bvVMYu3s+yW2wsSLCl9oyn3K
	H/vd679o1FZXZTH11ri4qNAsUPMaFoZTfNNJPCiRcjKJ17cQk0veiqt5tgAZ5E1XctXKgp+/+AR
	86E7RTEN7eQE/fMSJY68ZtEdA9BEd9hij6oFVohzUHhQgrGOFQBxzdnNXZXFksGTXSMV9wPZB+3
	mDOefk+YWlfD6mFFqCapO
X-Received: by 2002:a17:906:81d8:b0:c16:12ff:dc93 with SMTP id a640c23a62f3a-c246a6ca584mr1096820666b.18.1787386651869;
        Sat, 22 Aug 2026 01:17:31 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296b8bsm196582666b.16.2026.08.22.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:17:31 -0700 (PDT)
Date: Sat, 22 Aug 2026 10:17:30 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, Puranjay Mohan
 <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iio: temperature: make headers conform to IWYU
Message-ID: <20260822101730.24b93e62@systembl0wer>
In-Reply-To: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 10:02:27 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> This series removes any instances of kernel.h in the temperature/
> subdirectory and cleans up the headers in order to improve readability
> and enforce IYWU instead of relying on transitive dependencies during
> the build process.
> 
> I had Gemini generate a summary (a bit more verbose) of changed headers
> under the --- in each IWYU patch to improve the review process.
> 
> This is part of an ongoing effort to remove kernel.h entirely from IIO.
> 

Okay, initial Sashiko review came back and I've missed a couple more
headers... will have to send a v2.

-- 
Kind regards,
Joshua Crofts
