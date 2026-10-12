Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578B3DA7E0
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839866; cv=none; b=G6Iz0HhzKjxiUnEnnxRpIc1Unf2nuwkI6muckp7B5YIJnn7vOaZLo+/ZjldnMmCdBKdGSdyrG3rreai38WNb8wMfiv+guPs1dRM4AqyZaFleXONL4ZhRifr99MeOD9KwPcnkGrD1xNJmv9TaYBgWsKbN3Ya/ZzTD5LrvdIyKGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839866; c=relaxed/simple;
	bh=ZOaV5j+eXuFSiRY/48xGC3VEaW0+/0IwPIwLqoa+0WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1ClFPDVSgd/OowhFmwAAGN7Wqe56mpxLn+3SkkjhBF5Tj9db/5ew9Sg8dX4d49iI/2Vr9M4nFyQDi1YNINSTUkkCMCG3yxTBfdeb3Ay5ozpsEJOrDcTo6OkKIv8VQQbaPiu6zZJRksi7M4cupZ1eRN5tuhBR2lvc8uO0y0vfCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiCc+2Q/; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiCc+2Q/"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso5796789eec.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791839863; x=1792444663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOaV5j+eXuFSiRY/48xGC3VEaW0+/0IwPIwLqoa+0WA=;
        b=RiCc+2Q/dfpmswyVrpmJehN0lyNki4pV09gyLNQ6Va885M2TlXH7ovKBhxII5KAxmA
         ddclO++KwQJpJbsjt0Y3pW8qt3r0Ef8G8wN8E1ti0JqPo3AU02mWFNHSbo9Lfi820W2n
         GlgTXYF4HqWovS+QvxlZGE4LTtgkRf50IsLWGTrU68+mlR4mK6n15z5ETEAT8CFevwX7
         I4sC78bcvHUJjTS/NdWvLqXMiOWdBL5x9hfQ/kzbHcamCI3s9mreJhmpC7ygXAV2MF1u
         6Fl7kqJCoWhErgxTQcSCQYC4xtsAVBuzHI4QwuAIp66o8dqcu85BBRbi2DkEasrW+cU2
         8CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791839863; x=1792444663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZOaV5j+eXuFSiRY/48xGC3VEaW0+/0IwPIwLqoa+0WA=;
        b=mb/pZFFaFwgXBB7Uk7bvsiL9O53YWEzcf0sr+fwFvJa6NNayVEqUI+cZDU6AnZOPUL
         bj2WxULNeOy8PRv/sC2ticBR8TyerEQjJYV/uc9dEcA0JW7EEuDAH4eauElSvszuBF4D
         34VKyuWQJYeaKkUyqhtRYlH2dJ60o1z+a6zzPSsWlIpkyfCXkZTy8uTZqPUiQsrhxo0G
         k/nnLlLYlffH/LyFNKSv1uyqzuSjkJhujQsBRzE0WLtNrzwfOwPXqdPmFp7w67LEahoQ
         mJ65Ig3dy5Ea0J2mXXfJVAW7wk5q4eJyOZ2t5L+nAQ5aSoXzCyaXDLzfHVOP5r4O1KMk
         p/9A==
X-Forwarded-Encrypted: i=1; AKwUvByBv/ZBexbdr7EBj5YEiNhUdwfLgX4C46qG1RnBYpCIJtAFpPyPJtSKLQwZCjA0EhTPZqf5oEfLTaQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVoKVBF0NJdvVMOmIjBLcoGjZZGcIUrxfFEW4txbKRUEDLrMeE
	Ze2KmlNTwLGSwkTx4BA0Crl/whZqw9EJfjP0el9EzE+mVH4htWbI9Lbb
X-Gm-Gg: AYBFou3kaXGSxiK/PD2gwAB8olN/cJrveW5ODHfAgmeNI32gwbF+Pr346qGMRcSvv7k
	meZTbrFbYlVtAkY+u3gQU3oR3uR4NLY7ffLp7yDQiccDIa7yGWg+JYqeV0duCvS7WlSKHI4G0Us
	K5PDpw8RUz92RR3JAFzpMwalAl+5fhJu/Ph7jeli4GLDtj+qDZypb4JtFvCrcZ2pqJog9ypTc91
	bfvqnvtFeB3fi4GLCUCe5DZw5bkNhOh2t+yJlnMPUCbtRJck4vwZ3qBXcNRDYt0FpEIDZJpCJht
	eDzAKCJtu92J7jaKu+P5Snj6vr11/cSuFqGQvN7TQ3emCipxuF5vB8EwCi+sMeLtBVuk+PGeVCo
	pXGue+H0qNpwbmsk46LdSk/qJISQqX8gT+XFpm9NK49uvXyBDPNhxVl0iSI8HMryhEZHUQUC/1f
	5GDdPhUtPy19w1MaHs/azlGfAQBK4TNZDHC0zK9eAqUXg0lj9bAUilrgdgjrLj6cZ48BoonWJRz
	JE7q/H3enoq7kyNlmViTZWXQkl1+Qv1TJw+phCk17uUmvBqaspPHwlV9P2jxp0ZIw/PXT/NrHV7
	3IHuW4Jq+b6zV2vk7mYKrKD99d8Vfw==
X-Received: by 2002:a05:7300:8245:b0:35a:7464:6159 with SMTP id 5a478bee46e88-35a74646242mr5454876eec.34.1791839862310;
        Mon, 12 Oct 2026 14:17:42 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm39147488eec.27.2026.10.12.14.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:17:41 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: common: cros_ec_sensors: use sensor_scale union member for CALIBSCALE
Date: Tue, 13 Oct 2026 02:47:30 +0530
Message-ID: <20261012211733.575305-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011191641.4e9e2ac4@systembl0wer>
References: <20261011045410.356156-1-kapoorarnav43@gmail.com> <20261011191641.4e9e2ac4@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 11 Oct 2026 19:16:41 +0200, Joshua Crofts wrote:
> Please add a Fixes tag. Otherwise looks good to me!
>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Thanks for the review. The mismatch was introduced when CALIBSCALE
support was added:

Fixes: ed1f2e85da79 ("iio: cros_ec: Add calibscale for 3d MEMS")

Jonathan, could you pick this up when applying, or would you prefer a v2?

Thanks,
Arnav
