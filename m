Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778447;
	b=L9vKAfyOxWhgOrj0rIi6LE2yEBYBwU+ktkr0kTLJpUdjs6rbEhIkhmL2f4xbzHHiPYph
	 54xCfK6mnck2RmbOnkgtMJXZgel64Sm++LQ7BnxP9RFOV3eqMt5L1DjfRofRIJLEctEVb
	 pIin3FURY0QeolUkpBr2qF7F9wPfrFs2z3oWZgbMdsIVb+Xak3zmUK/VcKHqdEnP7y79M
	 KvfTvSu909CQubAF6smkS5/rGOHpwEyRm0OkeiLBItV5umUd+7g+6hm1GPu803as4V5ur
	 X5X5tZVnhLrwf+9oNtZt6Xqc+wAim2QVSVJVWTeDlGb+1jxy5nbAXQTzMJxHfLEHPQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CJrVpzWSqXnZyMhmYQZlXezsPnpuAEBGvhZcWkwrTMY=;
	b=KD80pAxmZer/EXQBqIb9FpouoTfL0AkHjx/5qFW85gpgUzE3IM2GQUCq4R19R68IOMF+
	 vF1KobUpwvC13fMgesd4b938MtwretskZ9x7Bm4fWGoLntEhN0ozfEd+xRQPQNlBCbsZH
	 3RPG6P1pWOObx7m8Phx0/DsC30f5SV5KbR4x4LWkPOchoEVGg78BTua3Wj2e5i30ifyPG
	 xo5gO8QCD1f86beSGa0tjsUzLal/G0woTUc76cEW3YsQGkTeiZMW/y4lJjQcI/7eimtlp
	 AKvsKadTfXOC9juTjSfTXjAjMlxzkvenZdCe2RwZ9rAae4F13llEV67i4isYOr3cGWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YC3ClFBe;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B0606D80D
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 07:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B4B0606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YC3ClFBe
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so1824405e9.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 23:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793778445; x=1794383245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CJrVpzWSqXnZyMhmYQZlXezsPnpuAEBGvhZcWkwrTMY=;
        b=YC3ClFBeP8skWuz8WHMGy4e7IPunuP4E0neJAvsPYxuk4p92X+lLQY15aWNDLCC/ed
         Yd05k3cVKi0y7MNyJr+vJNGFp5y1OXdKiwhBoxqU4l12tyRWU/cNUXNvU0YmCV1Rao+E
         R+k4MfdfUuS+Oe64aJ0CmWjLG2kb8pDh3gJlBhwy/+GUjqq1V9Bq2+3RFZIiSy+9qvQi
         l7DjP6lhWdNbCEXdliwIygX7LgkNRrIzIh0GyRLQNtISfIe1hoH510M3WfVnv/eA97m1
         YacxX8PN3wzv0irjFLl7iRqy3baQVHxNhT/rkjp94DCkd3S4noUFh8Cl/mSZbt1RZOEb
         w8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778445; x=1794383245;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJrVpzWSqXnZyMhmYQZlXezsPnpuAEBGvhZcWkwrTMY=;
        b=X7dVteiG9uYJHktEnZl7N3ACexZtTqi6xDvVPoVpjtRvykT7wJQXXS9skzP86jQw22
         b4kKeFWVeLWxx8nzXNmgIYZ2ATqRD37sLo7i2BSwsQvDZShvOvhNlRe7eWANEKyFTWLF
         CjIQSRHOArBVy9cr0CBYnoM4Hwtjfl4svl6KI3mfZqkkWiW4c65nnhlQ/3tA9FbTk/87
         kmK61VgtK+hyes2JpYPBwpt2/q/Hwu9pnBJEt4xledufAfrGDVSIwH5AsCfYS+sCexw4
         xDsLZcQHxicn5KbfOT+FtOFPz/xOY/BqL1K3zUJUW+tJktwtYwPsu1/WW+m5tVXd6kTD
         02/w==
X-Forwarded-Encrypted: i=1; AKwUvBzWsGyCs8j03e81J2CFuTA+5YGEroSJh/Tcb5CkeYhPAs6NUBtpirkPa5fdxx0H1aIgWnviOVDKZiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BxWZ27vyBwI1NsX2K9N8Uwegc1Jb5QXaTWQnyDsWNsVUbr0uS
	WiJvmP8jMq7ZrhTdO6qfKqCC8gnW/RgN2usVFlj6V97PenFhVAk6Zuay
X-Gm-Gg: AYBFou0qq3DRZcccy6Vlnr6Ir/DChfc7bToQBPih+j55v8OttrwHg6fagEO12nY5apX
	Xl1xhFqkMQ+G0dQEBZPFoXfBCzUbcGLVEgznhF5x4T49TrJsXcbFWkqR7OXp/iZyldIQa43vmXf
	LmqKykOrlW5mJczuZ6ZrcTGk+K8+RAAuZ9k6V67zZtRRd1EIyrXmCRDVzg0YMM/onD3DR0i2E4S
	HliciCx7nbeLb4jNnUEoH+QLy93cAFUAQiN9C32Aaryoy+fi+vVnAEHFD33eHd9ha/+DS4hY++4
	DDDk/cpu4SpkPXLMgqSd/NuXwT3oOY9jwRWL15jr//pdzZLorIbHB2AN7EI0NRDYG/ThZnP8KI9
	gwSilSUXk1X/WP7+z6RvrhekHTGxRSkXk5sRhGPteQ5AwLh5wwmm2AHtREvFE7dxwDfqpSLp3O8
	5oS+TwMjobB33tZRAF7UTEdjaH2+olTo2YMe62bNOb2IRWpZXortHJqzoGt6zszM8xLW66yv/OP
	vWfH/i7wiDPZHV7p3dqlhLNSsZgP6rCke0RXn0Od1JRV3pSXXIoD1YJP8DiibN8vp/1UnFZoXHW
	xSMu4kCe6EVgwU41hO0F0RM6SHMmJE/l9xAastx2FNGmv4eB0GVRruiPI9+8DAqlGSVxtPKgUFf
	68/HQFa/6nWr3En6BbFzYVCx3+l8+BsuOwEDO4Ax/r0QmqMD1tnBB3iBfdtmUFVgxtOO0gnAzgB
	Tws4gFeaXMycg=
X-Received: by 2002:a05:600c:4fd4:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4ac180f2ff3mr345570805e9.17.1793778444927;
        Tue, 03 Nov 2026 23:47:24 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab010a66sm164324185e9.13.2026.11.03.23.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:47:22 -0800 (PST)
Date: Wed, 4 Nov 2026 10:47:19 +0300
From: Dan Carpenter <error27@gmail.com>
To: Maria Sheikh <mariasheikh812@gmail.com>
Cc: outreachy@lists.linux.dev, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, gregkh@linuxfoundation.org,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: return 0 in
 _adt7316_store_enabled
Message-ID: <aurjB1B5sRHC6GsW@stanley.mountain>
References: <20261104041237.7978-1-mariasheikh812@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104041237.7978-1-mariasheikh812@gmail.com>

On Wed, Nov 04, 2026 at 09:10:45AM +0500, Maria Sheikh wrote:
> _adt7316_store_enabled() writes the config register and returns -EIO if
> the write fails. When execution reaches the final "return ret;", the
> write has succeeded, so ret is always 0. Return 0 directly to make the
> success path obvious.
> 
> Found with cppcheck (identicalConditionAfterEarlyExit). All callers
> either check for a negative return value or pass it through, so
> behavior does not change.
> 
> Compile-tested with W=1. The disassembly of adt7316.o is identical
> before and after this change.
> 
> Signed-off-by: Maria Sheikh <mariasheikh812@gmail.com>
> ---

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

