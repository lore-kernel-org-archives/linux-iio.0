Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B368388E5B
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189347; cv=none; b=r8JAjWvlIa/qP2NGhBlSZe1fYdl8jQhK4e5vyjjj++jqWmvCPylXtjOBrMdeINqfzjkfmFtfrJx4BhEmllzEOrLfWLBFLdL/4gyVr66Rmt82BYopZXVgWiBdlNsbvngbdP+nlIH9ULhFotVNM0vsXaCckvWw0YznZQ3DweRh3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189347; c=relaxed/simple;
	bh=5Jdv+qCy8zGDihWvfKYhvg09vaPh6PSRvuRMV0IHP6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mC6O78LO/IKLRCeaDm/HvpjMpKZLiKfu3lfrP23TwcDRdheEe2yx54+fqi4tyMb22oEiu2LRHm2ikbhKI/sOdqFrlvL/CYdYC3YEFC/3u0AmvwgE7Ptu/pYYNphISyl0BU4PdEdRiBAF9lQuJpLApuIvw6PmZPiE5sxq2lLQGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAQz4h3r; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAQz4h3r"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5177945a22eso56010711cf.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781189345; x=1781794145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Jdv+qCy8zGDihWvfKYhvg09vaPh6PSRvuRMV0IHP6s=;
        b=AAQz4h3ri9Va7tlhhWJ2PTkYlRwIo/B+HAMDrmeK8xzum6DxlR8E0RzzQQsB2dsWnY
         S4BTQsmSpeAaeeae3aw8lPYUk9XhPlBWMolPtKcVUua11qCPOrqGnZO8aM32V4v2M5ca
         vH1s82JGxIn+blnB9F5rRIBXCAJuuAvOPPNIAcwTe3VppPEMGNfo4Wr+SlDJvSHOnEMm
         tISqPN8X6UnSu2uZ11iRVOnL3GYZ7e/Xbl8GDhTtxYzmjPMGrSYwCsXwOOfbu09zqBHY
         eIW+dREysFGL27rYepVtGiRpymyhiLOxKTsXkKCw3UosOLufj2cmG4JXUoHZlyN1nZav
         /vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189345; x=1781794145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Jdv+qCy8zGDihWvfKYhvg09vaPh6PSRvuRMV0IHP6s=;
        b=nUgIPk529+4FckMQr8vC8HeGDJk43otZwfaXjqf+L3oyMOWPUyzXXDSqV2/vKYAeyw
         xPiyDxRw6FrTANC5gLCqeIpOq0VyZwnPU/Rp0A+DBWDbAr2V/YzJCOH2ttTQCf+ZMXr5
         h6oHkf1r9Oi0vTzJIVWaB/giHztcZHSaQN57dFKDj3kKPmeX76yuRXsL10Gkrc+gNr33
         mTCXq4kouZKsHme+Gb6dmqYA/aMwYgLiVxpY/s4LzDnTlkUwCbLvZx5NZf2hgR/ZBnFe
         tEgtLn+3NOo7Lf0gGrQe+0TcP5wLiaPVMmzIgSUu79qx5ap6+9JXo1qjIxnUJsgFlDeE
         Vzog==
X-Forwarded-Encrypted: i=1; AFNElJ8W23ipQSo4uwnscql8ROkt/E34+7/0hfLQD9FBiYDU2veBhy01Fq8WTCfDnwfaluVN3+HHwpUqs0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UD9HtVjLyOXGnaB6Ipe+hs++J2Jl1hNdvT4G8rY4aGD7OLPU
	/+dlc8inIsBaCHX/B4A4GSbYGMmxxinT2an0FFBhsD5FyMphFp/cqxJr
X-Gm-Gg: Acq92OGbFdyGF44uhzgd/z5+etB5p4wAReBlcDh711F6AmnpuM01FXJoQ4KcIJZ0s1B
	HFh3G1xp38HEjXqQEt6yZkVZZ1g/icGunmFO91LwlJZOB1QzveIbSwdBwN1YNKIK8w9C86egOwR
	wx2Ok+NKL4ZIJQ/UzbaYs0Yjnt+jcDRc4w43xVk30b+GHpQUp22aYn4GY1HEeE8UpbX8yU/0Sh1
	52EU4imISw/z6TtPlLsqGKKn4fyCmbkpt1VRCfL9IdhslIms42iasWQAVvjYafrioM+x4/mqLxx
	s9tp6aeIsm76ERbdvfJrrC99MYKB+uSy9Rmp/chXPEXKrineteNvkcj61J3EUPXTn81pjRPPiIS
	IfMp2Hjui27Br0UPRAx1OHZc61G+k5Nsnkm0/Bbh6j6/5+uPlZM2XoZXab9zCF0YaUvcYyfHXpy
	PFWMs+Bok8cJumKzvMzg6Znkp4LF8LRVJDxZlyPlETDtv6iY1JMfcgnJkTaw==
X-Received: by 2002:a05:622a:118d:b0:517:675f:3ee8 with SMTP id d75a77b69052e-517edd0f6a9mr47526821cf.12.1781189345268;
        Thu, 11 Jun 2026 07:49:05 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1eaf98e6esm19187806d6.39.2026.06.11.07.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:49:04 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:48:57 -0400
From: Louis Adamian <adamianlouis@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: Add MS5637
Message-ID: <20260611104857.6efb5326@louisarchdesktop>
In-Reply-To: <20260610-broadness-unraveled-b5187dcb2fb8@spud>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
	<20260610020458.104818-2-adamianlouis@gmail.com>
	<20260610-broadness-unraveled-b5187dcb2fb8@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 17:45:52 +0100
Conor Dooley <conor@kernel.org> wrote:
> I think this should be made clear by use of fallbacks, or being marked
> deprecated with a comment.
I will mark the generic compatibles as deprecated with a comment noting
that they previously all received the ms5637-02ba compensation
(following solomon,ssd1307fb.yaml).

Thanks,
Louis
