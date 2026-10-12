Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A59345EA8
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811352; cv=pass; b=PlbuITwlutR7QKpW7tHtXR16O7N4f9sPKn02ffa9LJD64dXBNYcKf9TinF+z0W376ttp1UHEqFEQ10JX9TEO1KoqqYhpiYQdoPIdEcPzSEVRz0T/qhlTlcikUHeHs3vm7kQ6EsP3C/OyNWJyjZL8TGBqscvyEjXBFtZS3l8RxZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811352; c=relaxed/simple;
	bh=wHRi+Oc404e7CHAB2GIYQFXXtTwKqetx40dVUrZPg5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h36yJFrhjCGitqOLF9E37FzBTQwsW7Q/dsLFbN+NjR4aSKHbf9JvJwXGUGdP7BfE9PLzrfKRprYAtRAf6Yle0lZxMiAHScrofzobcIGFqhwhT3CvWZwXZ76zHxUEYvfUuWOFu6k2k/AIvZ8943ifGCCAbEXWaHZcpXKRdvnz428=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKo6vr/V; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKo6vr/V"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-451a49abd8aso1779414fac.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 06:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791811349; cv=none;
        d=google.com; s=arc-20260327;
        b=EE0wjOSg7gjH6GTupwZYDzfr8AN7KsLYOkUlxfq9QLvOqal7rrOmqwnJVRKzQqE0qd
         uj7WLZnc5qICXXp9DtOfEMEq40ye/FCimn7pMfiU++f2sVdrjx2dzJwYifc+nrDkYzIA
         0O4LYQl4xiyrAgVejIMrIoK0QKTyRddzP/imJz8wQCfKiBvCyAAp4rl9ibR/unXMqCnx
         K+2mN+3ARZ5HJWcWoJRnSzNYKZsPUn0eEYMR7fc/w2jPQVR8Zzli94itSljSlyQlNOYf
         9qx5q73ORUVwoj1pOBXsrnVPEyZXLjUiqtHsfPLc78T93fu0D9BWr1BGu11hx/B1zt8O
         UNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wHRi+Oc404e7CHAB2GIYQFXXtTwKqetx40dVUrZPg5I=;
        fh=wrLzH0etwKV82Oh/wzL+x8a2PQd3jSr7y+9V5ULgEJU=;
        b=o/bk7H6woIVpgL16V8NIiyPT+S+VwfemYpoAVeIwUZvOyiJq6OvF3zRNUAvK1evhnE
         LumnTRpM3bsszj6roOeuXLqW4wASeJfHqbh+ro0m78KM8myqkcFDgEXuP4xK6Qrar4fh
         y7dOwPUusrGL2tTCopHKsyg5xM7084lLUF3B6ksK6SWgk6kR6pOG3KmGPnKW3Y/RNdec
         xtJXhBB+Q0UYPMjBclqxccDO9nLsRAF4IFe7xyvuXxQlLPwXR1FXKkKdnVF6UBFbiH9H
         JzuBKOGbAClOAMSfn/JNWc/riTWloU+9cB+WG+dU2F6qoDD/mjRsPZlieDmDJeRdFlx2
         rmzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811349; x=1792416149; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHRi+Oc404e7CHAB2GIYQFXXtTwKqetx40dVUrZPg5I=;
        b=cKo6vr/VBna3UoL7i+xzwpRUrQav/SV7LPJ8lD7uZGErUM55kdnQUkIvwYr34v8kTE
         Tvk0Stfa1EfmjASvxkYPodAEqDBDVglgVndyf4ESDXMiKV3Us/AHTHZg1MbgytsPxKl+
         kEY1+fWZjJlkjn8FnGn72u4DSXKG0SiMhaUt559m8NY/JAnQ+Iu19hHkpzwmy2UcNHqp
         karcvehK5/Nf5rT2B/s35WCHEl+31P8Y0LbM/wfH43KgZjm8J9zmsPyzlMe1h4PAxVyp
         ED4kn0Mtoy06gOV5XGxC1HMZSLB1QVHPQ7zkJVnPwZe4MFdsAkhF8qoej3QnnFgmm5sf
         n+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811349; x=1792416149;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wHRi+Oc404e7CHAB2GIYQFXXtTwKqetx40dVUrZPg5I=;
        b=XY1RP8aMTNdbUrZYUL8B0UxY14zjBgzvh5gldc/Wk4SUtGAExEiDk8mT7IGWmjYSFd
         FGHyok/Eg1Bk/ugDy4/hwcIzSbmmCjTtzFg69ewxPqzRnDkvVuGmXmgj+xTX79XmiuRC
         PRLebv2PmQY59Bg8Gbw9qrv2X9KBhGvir8GqJxvlcDXIaOe7iygHWnWjz2xbnVRieEdM
         PHFIowKwgI97VRO4SaWLBUWKBHPwh0DbL4RsFsnGXXmPonXcIFRSy6kntilePJntBPaS
         pnFG2A9/Nh1pyO0bbpRtWvMz3RJQtDVsCv/66L37f6Eo+AzZ5fKZ++H/CvC5k1iT06Cs
         h9hw==
X-Forwarded-Encrypted: i=1; AKwUvBy67Fd1gwkCGSarA8JVWK9h8fsH4UdNKEXuwZq1x1pZTPsXm4Pj+Mb4rp0TQ9eSOMqpjKGw2phu78w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmcaJbWirmEoS2lqn4FM+IHEz0n9+4FlsUXO+B7VPEI9pjQQnS
	PjF7DVWaSajG7Wa+OgKw/YAS8HC5liVhyNgj4/q4FoNenvIhW1apzQpHkFb8wETwvWkJN8uf2xh
	cE7O3A3S5rJ+Nn9UAhh+grzrfUXengf8=
X-Gm-Gg: AYBFou1K3j7rcHStDpNTW9nZc3NUQuTKv5d+Ba10L/Z0ECKEOI+1Psdkvfrzsewvuzf
	hZpVglMUyiosrOPKT2NVFr+O+wdpzzOgp6OHieo/DmS+zncPUQySNJspqRiSlrlj4vyBt1NsfF4
	wZ2MXEqPJqeZbAFaoygu1midPGYIxJtiww/Xlam7GvnKHEhciEYD/9foGtERoJLNJfR26Y7RtYD
	FCnSegi6uS8x4RrVfeskHBNAi4yfmAKqOZRcB/KYw9ToCoqJnbFyazITDg+5jUGxf4b0JVzMyqS
	rNr7Ow8slLW7dovq6csxJ/kAoxA+jhXhpy1CWveJGk42BmdyjLZJqMn8
X-Received: by 2002:a05:6870:8929:b0:49e:f7c:fa52 with SMTP id
 586e51a60fabf-4a2a8a649a3mr7055634fac.36.1791811349384; Mon, 12 Oct 2026
 06:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
 <20260929184900.39515-3-abdelnasserhussein11@gmail.com> <aswW2bAapx3318Zd@monoceros>
In-Reply-To: <aswW2bAapx3318Zd@monoceros>
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Date: Mon, 12 Oct 2026 16:22:18 +0300
X-Gm-Features: AclHuK8W8Rlm4uemP4cn0xb4FiJCWYATf-Tyo02d_DefuCSU9DtfwEC-86YeR0U
Message-ID: <CANpqX3YqJ307B7p_q1UsZco8MEfO8-rGdaUtRsa20KahxpJ9RA@mail.gmail.com>
Subject: Re: [PATCH 2/3] staging: iio: accel: adis16203: add missing
 spi_device_id table
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com, error27@gmail.com, 
	narcisaanamaria12@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Uwe,

Thank you very much for taking the time to review my patch. I really
appreciate your feedback and pointing me to the correct headers.

Your corrections are very helpful for my learning process as a
newcomer, and I am grateful for your guidance.

Best regards,
Abdelnasser
