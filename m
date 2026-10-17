Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5963D9DB3
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216786; cv=none; b=bktQs5djUR/pCcejJD7MPqhHD3FFihYu9NV1Y8OoQ6THKV7aBPwMng3o9Ah0gP0UMeb9aweghBMv0gtvbqR7kAsjIa6CLwQ8LBKQX0L/UNDD729n3XdBKN7kfhObId5b4LfPjawVMjkhbm1qrFzZL2yhHlzl0sp3hjT54oBpU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216786; c=relaxed/simple;
	bh=P3dIQtl58vlK4vCvVGpo8bRmfchguwl0fdNJtOmLjU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hv/AVDO5b9K612qFz985IXggfEGBh3Ngj9pmfNSOudyvrJwmCPTgY3Vw+uNxn0JjyGkzp4L2ZwuAm/bldpyzapCP1FHIt46i8spSjjGuE3lmypB7e3ABp9SZ00zLPpx8T2mkBREe4L+2YgXFTvr3GtQyNhsLPM4Ev5ujwr7BHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck7CtFlJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck7CtFlJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956869750eso3272575e9.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216783; x=1792821583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6YTnAJbuDLYQXb15/j1+EJM9ZwYexvHGmO5mPLB8bd4=;
        b=Ck7CtFlJu8xLO15U+xw9yDDipRWoLY42+accE5BtY+x0umc06+S6qWUDdHdN3G6U+b
         9tNmcqXNUiQ+N3vGFxIZ+xwOGsvRQq6zsNUihk7+moLH/v6ZEUIqthalOKPUkcB0Z8c9
         2rVT+1SwBwvFojXHf1AzZLZFZtrkFNlEnedLmq78YBplfMoFgUk77wCD06FPG+ON7KwY
         NpwjNlkHZkkfUasSoBBbTOPqH1irgTBKbDkjwaHomh6SYtHyFOdGU0NaDTgkRhw8qk64
         D5208c34wXrhw8ZlU8Ky5tSRsBxiv/SnMuqLrCcwzVZ2kOO3DbtBhLy1MR1wdbgAdIbl
         BgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216783; x=1792821583;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6YTnAJbuDLYQXb15/j1+EJM9ZwYexvHGmO5mPLB8bd4=;
        b=gEGi9mdJHXFMtx2+w0V5tqaFV2YvjfDoqL1XNLNve+umCXJhX+JJg8AEhZKHVe26kO
         f6pXoRXKf5EzzVQYJXptGzTrMgKXCbDVYURTrsHdWjUMk/LYAT+yY9KO4eGN+trGyx3c
         5bvS8r/ykSrK11iryQT1MBwxqZNxtc7leIVMYk3UlOUHh0Mfdc82yuD9aoyjlkN049dB
         hdjAHvMz0feCGiRb3epbcAssB5k0SaqxwfEjwYqDBLApJLWkm7WEsPoSifpJhTuaIJhk
         Z0UbqQrNgRqP4oDmVgxeIbvE7HoY9o6qB6oGrvPEWef0CMnj2MrwfSbeOL7YBpaBvSBr
         EL2g==
X-Gm-Message-State: AFq9FYIosiLvUrSb6V9IlnTFl0fb2lyGMiUrOnM9BEucKYQriWZIwBVe
	DFtXABZYYq6nYbVTQbE24DDeysLrNHOtJHNBOdAzO8oEj+OlEJ4DYa3a
X-Gm-Gg: AYBFou2YkptI5N2yLNTB0WLtHoF8dpajsbn8hx7bMH2q+MSgcYVi+Gc+s/AooDyGKbc
	miil/PJwK1zdhsVjMPntyCxu1Se2A9+U8l1gyglcIry/XDKI623M62ILoK4SO2fQu2N7zsIgI7I
	Lt5qpJ3XK2idY48/OHuDZch0v0g8YgMOBc/C6yBpLFKzyPLozqDwqYDnBO9/Mjb2V2t6HenoFae
	j/csSLA3W8WFzjekxIayB5hJfUShaZhA3v9DVUTxphT3lQE1yZkJtnek6nY7Sb635viBym0+wpQ
	wYtongn1pZwpOrohKXQD5FzoIZJZStWrKlViu21qDbfD53HpyYMASqy8GPW9ZovmdmBZXag8jQC
	S0J5PvcLx87jT/fxHXV7UBHIk1IDLmoYw28OifHKuo7ZcCOxp6tYHaFYK2qN6Z2Kvpg7k1KHcCP
	9+Q3XXGlZ5op/RAE9wPUJBVBiyNxmNdV5186uqmV53vfyI9dPVcaClWv7cxwuJwNmMXy4oJESQX
	PqBBLpyFnemWEwBex5RJ1Ms2O2oIKZpyyaljWfd4xf0/Sm6IBzg513rv/JC+r6GG7w+McNJv2Sw
	WKNWhlT/GbkzTIWuSpAxtXsfQIlLbrgKqvQ1PUuv3NhSQM2A0a90u0myN696JGc7XFvQ7nmSHos
	iIT41DozClZNbO2CjLuWS/MMkWwOJYsaoT8vBqionjhREHIYlj+RpCft+rr3g6XzONRGFI/lreF
	Ly9kk=
X-Received: by 2002:a05:600c:4f94:b0:4a1:a2c0:7b73 with SMTP id 5b1f17b1804b1-4a1d76086damr33196555e9.30.1792216783026;
        Fri, 16 Oct 2026 22:59:43 -0700 (PDT)
Received: from systembl0wer (109-81-110-61.rct.o2.cz. [109.81.110.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca43012sm45595395e9.3.2026.10.16.22.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:59:42 -0700 (PDT)
Date: Sat, 17 Oct 2026 07:59:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <jic23@kernel.org>,
 <nuno.sa@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 09/15] iio: adc: ad4134: Support buffered data read
Message-ID: <20261017075939.7c9a8bb5@systembl0wer>
In-Reply-To: <dcc159585f0af92c145569331063bc867efeda8a.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
	<dcc159585f0af92c145569331063bc867efeda8a.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 22:59:00 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Enable users to run buffered data captures triggered by IIO trigger device.
> Add an IIO timestamp channel so each data scan is provided with measurement
> time information. Require single-read operations to be in IIO device direct
> access mode to prevent buffered and single-shot data captures to disrupt
> each other.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
