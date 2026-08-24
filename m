Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1E364EB0
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602074; cv=none; b=BlaBYnOj2uC89vNDidqCqiqLGhb38cM1q3H5CARlFtkGp6mrJIL5a0G28SyV+gi5gfuolIWftXTfDZ1xDNrPqWbUJa7RWDCLcHx7GwbuGOxbwP5IkhlgXTANxQ8HpuTKp7ExrLhaEISc5dWOSEQCrKuu64TPoCZ8+0c6zZFDMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602074; c=relaxed/simple;
	bh=4yM/sFeVr7m7tc32JHxEfeAb8FWrpW3YgqN7edtegr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvpoHPL3QqWnQm/seYJMMaCKATgBOmpprZc2UqDRq6vzze3ed2LHE93E8t+oUngbykqHG67WibhbcwTj0aWPRIIeik8xqU2GPYX/hyjd7gbx7svhBYE3Ape3KxG7UoIc8ZMqa5mxGoaWV69MJotsMWllghQUcQk0vjKkRzz0el0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcgQ4Nw8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcgQ4Nw8"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so3838164e87.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602071; x=1788206871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxOp/lB+MXkBAiCJKeOanQBiepDI4CPw5IwKo8UCfQw=;
        b=AcgQ4Nw8l5MmiKUYPX5KMcYu9cSrfjDutjgTx8m7hwc0exzSsp3ynVtcSC/m6FlNXE
         AYV6HOFayb66XUIBuHxVY6dZCz/puBuzuSANPmTkH5oAs9BOyyBPd+ZxQBVHWT6A+Ki4
         zO/TAgQbDmtqSq2xRYwTw4YOcqvgfcl34KHM/ct8A18lHLcyhti7nFwbobldmCzz+acJ
         Ztxsu+GjxPBS2+DD6VSgnUeDSFJBQy3fohDXhUJxOga57YEwqBbp8v5eBShNI2JhxW7M
         HMRMPJBCq8Iby6v0hHglUMMWd+I+LQdoHxqv/86/rJny96gDqgT0VPtb+NB3Tv5+NP5X
         J2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602071; x=1788206871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pxOp/lB+MXkBAiCJKeOanQBiepDI4CPw5IwKo8UCfQw=;
        b=E0tJah/R9fLrLjV1V30MBhrL7gTmIERNLC5XAuNvfY7t8c/cRK/TTZL4YwdZ2Iksvw
         +5Xq8StkNQg6zdSWPtP2xlwHxoJFrypgdMHEi3Wb43locm1j5FwtfOgt2fSoctOOsmos
         0E7RxUw2nbqdchXfHTcN7xgsgBaVsL2SZp1HLZrN6p/yvyaM7eaNwAs6pW/mJFpmTvmP
         Hlgp4ZKnhxdUpqdPpsXFI8j8RQSQZ4S35tmYbvZ2Zjsxgia++9PA2rCgJjv+6Q51Kqt3
         F4lOOYKIcLkEizrjtQFbwpEGNEiJuJaBLeJAUF+gKBtaQSOGs/2pFDLdbmLCu6r1C9Lg
         BfaA==
X-Forwarded-Encrypted: i=1; AHgh+RpJopA4J843hznIYEC3M4oV4FIyPI22spZfyPYhvw2FcWvPuh9c5xiwTNQH4+b2tedx266TzN4xw+k=@vger.kernel.org
X-Gm-Message-State: AFuF++nHWvmFLZep4zqH2G747hklk7CVpoYB70kZnyCCNekL4PArstuU
	P4AvhUDVy7VS/FEaKeyOMspDEoF0Q7JnCPHcjsyPSecBXJkSUh3/EEPo
X-Gm-Gg: AR+sD12unz/4wVtj+KXbJNSL2pd7PhF4QWj3IMK1OWJAu3A3CxS7CWlzrh0o6JL1UJ+
	yTwJ/tdzvNz5VrPmotYgqZZtKme/7ge0p0od8l8T40ALwKZtOpUx5E3dEH1AZAPFX4lqdN+oS0x
	ta8BRrpJcuhpvjQnIkJf6waXeujof5wnSKduh/cdWaqqUeJm6LIzj3OstrsqGj+fmu0pa2ke2xf
	DU65Q3r3k1ytGoYsWYrnRtotWOsZpAPKWyCk3zOr3EQ2WCXyflsr5tEfE3lUwdRwKNJL94lWQQk
	1wBhlj7o4Dhc5yOmUkxHWm4EFr7uv2gHwYGgYB9lOb1kofZ4RVa9TmTEIn89rL4RcdBQaNASbQf
	hN5MLzFMxKEVzc6CCysdYsXxuyjJUD3oUKz3xrGuah2vOJ5VGXFcErEsH+hVZP9tO1R9YWZlXdu
	Gra73Kgd+cDoPc2o0ue8ZOn3oTCDzpFwMyxfQhoutiOCj1+zIh2WDV70XqyfZ2VPe3iKCXAy7fx
	kAFzdt3yApXtR8E4PiF37LMcEdS5iQiV8YjbICuXdeADb/bBcQ1xb0Jzi8=
X-Received: by 2002:a05:6512:8381:b0:5b0:23b4:be97 with SMTP id 2adb3069b0e04-5b48421a625mr7340848e87.6.1787602071055;
        Mon, 24 Aug 2026 13:07:51 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48ce069adsm1914745e87.59.2026.08.24.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:07:50 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: pressure: dps310: add triggered buffer support
Date: Mon, 24 Aug 2026 22:52:54 +0300
Message-ID: <20260824200456.393895-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823001914.224aba09@jic23-huawei>
References: <20260817170725.1074078-3-zoone.rupert@gmail.com> <20260823001914.224aba09@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 23 Aug 2026 00:19:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Use the sparse markings to make it clear and testable - thus not needing the
> comment. __must_hold(&data->lock)

Patch 6 opts dps310.o into the analysis, so they are checked and not just
documentation. Clean under clang 23.1.0, and it does run: dropping the
lock around dps310_fill_scan() fails the build. Patch is last and touches
only the Makefile, so drop it if IIO would rather not opt in yet.

> It isn't necessary to use guard/scoped_guard() for all locks in a driver
> if they actually hurt readability.  I think that is the case here.

Plain lock and unlock in the trigger handler and in the FIFO work. Kept
guard() in the three places where the lock covers a whole function.

Rupesh
