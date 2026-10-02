Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41D429CEC
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970887; cv=pass; b=eYtgZyD533SVTWILxHwQwGPNG4xdUBzypIgnzWJlf7PqVYhSL5N9txLTUgEMWbDnJ8htOcMYW44VL9gghTryun3zfqjgRj7l729GXN2g3do7VZZOKgi1Z4/1rIbH3TH/oMmccOMUg797V5EKotruIWzPAm5B5b1D+4Z2hwuB+uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970887; c=relaxed/simple;
	bh=N0X02+qX1ELSle0mhMXX7fXns5jHMk1hbZWZ56LRbLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQLWowQVKM+COUW+qwNX1GBmDWbk10+O27qDbqcd7Xe26MzLuaANwNYulyJiu/RQl9mOnuG3Cv8xghkSZaUQJe2aaQ6vkY1yxe7fC2GKNBBTkLk3AQS37dhR2bRnncmmj/46YjAnbEKFtj7RjOiGmCyVonVKql/nMDlhq8Zk618=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFmNdVwH; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFmNdVwH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d8239so1972855e9.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 12:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790970884; cv=none;
        d=google.com; s=arc-20260327;
        b=UhWNw4eP58Ar6w/5k5tJbBb4FFUyOBH3F7Zux4UtxlsIznHmc77QVSldSCzTaAujt4
         YLA/l2SiLGtwtbH9vR8EellJmt7XgI3QgFTACLCDyrJmh/hG1l9D/GqrUjDcm/xndzPL
         QZLeBGRgfF5THT+1Yc+cbM6T9W9cvpZbfkPf3kLeEczjh6SDXIVz278EhWJR7WLbjDQX
         pxwM/szsi7r94IpFKF4CW+XJCR77SVuV5k31FOK+czY9CnIHi18vLBxTlFhRMM/VJ6LS
         /oMpNOh7cgxctkStD0/PfSTfYs2pWfdoiznBuLtrcHbZw1OaBl4cv2rmNb+jZ5yUnNTf
         W+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T56mB/qO7F2b19FjXTV0J3sIArXRsxwJOvZayG4wLs0=;
        fh=DoLMFgpuf9N8ia1WNuJh0WfAi/feWLa7K5HpRQGiEkQ=;
        b=TPKHhRbaWySqg4CGlxuQBTMTUNl7fR0CdmSU+U/lB+hwVuLzSI1Y9aw6yj9ukm4RdC
         fBgijGV/YRprsELyIzh7RpKh6FSyulF69hi7qa7G5TDJbKu1Gl1AnTKxVpdD7IIFkPWj
         YYl9JV3pV7ajhb5chATIqCq3vO21CeaZmGaZPyQRad9NnEl4/hDs6r1yq7cCtS7OJdgL
         tPwWCTrFpAWtiphK+8tbeN4wirv6dnj4OY9j6BahWE0mmqW7hwuD5GZbZ/HJG7zTzRkK
         B1nj7VGRRZAD961GlQ48WvtMrAiVwMvglBjYfrCIpL5WuidSTeK3wn+AwujXKfUrPgDT
         Lo/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970884; x=1791575684; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T56mB/qO7F2b19FjXTV0J3sIArXRsxwJOvZayG4wLs0=;
        b=ZFmNdVwHByKMMo1Pr13/PQlCjB/vBL1vIASx4vZmpiofJ4I6rkQqwc/ihiYzDQDgfn
         9FVqk+H25Y+jpDJB/GvFVgiXSolBbcotjvCLTEEU7GDtswMF82vq/Ha8RRWb5reR3h0f
         0wHG+wRhAg5SXiI9hIFHINzuuc4Tl9cVSmbDBwSFlxnwD+qMTCNAzE61JpZs0QjQdzMP
         gUNk4Evbi5q6hcMQsMdFejkCvbsGN04nf1pizaoxvhrhz++zfH6zMsPwmRxxYENZBC8D
         RmMup73HcTi19uuj76sZWGwmThPHOuoS2pJTsbwEkq5r8+eVwbhJL2xhkuMLvzwuB1yD
         CnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970884; x=1791575684;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T56mB/qO7F2b19FjXTV0J3sIArXRsxwJOvZayG4wLs0=;
        b=CobOj2rKMbaRFsm8guiA7CIpQL2oPWu49sKrCDtGPcQ80azHLmfyKEq7yQjXvQHt36
         uS3Tq3Ir3XMecaXnpH7vCI7vVjMY2wEfSoBtE0EBbq50ftGitvNKybhE78ZdTBL6B/WK
         F2xKrpAi945TjNYOx/A4NG9hzGFgMNGbZ0B1wdaFvJ2PdK6hTPlZiZn/Su46v0eqQb1f
         heRPNtcHMZh94NFbX7GKfGBKG87Q0NOhc1faGlkfDpqjvPxL8WD4OzYB9F7Fz97J3Ujs
         bkixzo5sY92s/MmYmiId6tnYijh29j13WkohBCZZdkCb0RgGesPcdzpldLZTCg6NSjwO
         gU7g==
X-Forwarded-Encrypted: i=1; AKwUvByHhMCyVnkK4RC4da/LU/ZcNen5zL1OlVrMYzvQxQb9fN2AkqALGUUl5Qkabrv5I0MwEJP891or4Ak=@vger.kernel.org
X-Gm-Message-State: AFuF++lEkxc3S7iEAbCiaiQgWAaLp8Udv4HV/8L0E6LXH9urAlsgnb9J
	3+3XqIQlDkXf1xI4xdlF1zhAHC0vjjE1HQR92QsHatrjYjdEkdAfrZpbbjG4HOnrWjvfSNBjxBj
	XmnHFP9i3lIA2omPoCm+L8XtDFJ9qsBQ=
X-Gm-Gg: AYBFou1oTuGl5llT3EB9dOCh/6FzCx55d5zNm4ju7MK92nLbkbwJTJiOskGMJD3L34b
	gU2LyN6mOU9I5whJp63ei9qeVZxe/lwFvnO+ndTIokJD1DZa1ffMwtcHmDMcjPjScehEVKaL65k
	2FyZdxttKml7Ld8d9IcEHbrf43hNAYAfvfrcQojVEjk2icxq3+ZzUzmD1dG1deo0Zz3MRjC6HJi
	WIDIrcF6VjKSmug6qrW8kV5Y6HFxwIGv9ewdtYTi6xDscACf7mLsXb1DTZ+OHXIhnr1n57jkb/U
	fznoJw2b7UDqgsFEOORTZbwuseq9h52BqE8+Yn4+u2gB72wX/jwsIv33O0NtLITfPcqMr4MWY/K
	pZcCmg4O15qW40wAmSOLDZtEqoMCXJSkiBQJ73jT7Yr5s2eLkgYsE7KnVw1dHo38SrsOWRR68jv
	miriouKSb8SpJ5Q96jT8AC+EemMHAw69hD4IipmnYEylXs1QD4W6bZPhj/uIOY2MpnC6IlpPwub
	S1tgDh79dGsGurhnNrye649ais=
X-Received: by 2002:a05:600c:34d1:b0:4a0:1cfd:321 with SMTP id
 5b1f17b1804b1-4a027579e86mr73608285e9.12.1790970883466; Fri, 02 Oct 2026
 12:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com> <20261002153302.5c64819d@jic23-hlaptop>
In-Reply-To: <20261002153302.5c64819d@jic23-hlaptop>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 2 Oct 2026 21:54:31 +0200
X-Gm-Features: AclHuK9A4vQb0c3SCwfTX0zGIN6ZaHH90-IWtc-T6bQxe6DLhdppT_Ep7cPDR3w
Message-ID: <CALoEA-z6Q3YyYZfLyRixk9dPy8mn+mmVJVUrjoCZb6T7FXcDSA@mail.gmail.com>
Subject: Re: [PATCH 0/3] staging: iio: accel: adis16203: fix axis mapping and cleanups
To: Jonathan Cameron <jic23@kernel.org>
Cc: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, gregkh@linuxfoundation.org, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	andy@kernel.org, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	error27@gmail.com, narcisaanamaria12@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Oct 2026 at 16:34, Jonathan Cameron <jic23@kernel.org> wrote:
> The driver no longer exists!  Support for the part was added to the
> adis16201 driver and the staging driver dropped.

This is also a case of "idiot reviewer forgot to check before reviewing" :/

--
Kind regards,
Joshua Crofts
