Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C73ED5C5
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054348; cv=pass; b=Zg3NklBseIfUMWrKm1pQVpYbfmsxDyArSlShNSFAqNzZPOtIYLJtZBGtN3cHSALq3Ke2gUCdbyIzdoB5VWEmoBu431WqDjtjtqq4RVFoUIYDtQnyDXQkJg3ty0Zp8we+tjS4W9j9ykfvOOPVum2rFYTrgCXanSVbsaTDTdfO380=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054348; c=relaxed/simple;
	bh=uE3d4Zd/YQ+bZ7wGB9dOxIE6MfbrhCeLYHYbduPFSbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YROgnIT3MeDkc4yIVJWtXFV+7dnEVF1f9SG7cLLSFry4a91tNLIitmUw9fGildMJ7pRcBF71LyO/p7yLjQX7hbY2COTPYS6Wt9H8VVNKN13DVgJQDLILJk9LkrOB96i3L7ggaQR5V0FE2YedVGo8x0vqwljvBXumHUYkPfuQIA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkfRPDow; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkfRPDow"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so6527380f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 11:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777054346; cv=none;
        d=google.com; s=arc-20240605;
        b=SYbmAx+Df6M4pCnpBSfr4DEBNu+v5F2O+TE/Uj412AYnyH8xYW0nABKxUyrq6d1HcB
         D8mbyeRuzKLCvNgQqJTjx8UEudXNViH5kpp2/WfYwbRJ+dyE5O8SiOBi+zcI5mpWcVRq
         2yVDL26irhl42V0bcJAMeBoM6j5DCRCAjgSDk2Tv2MI645iolibnis8gcUQ85OYcvpRj
         ekiS2mp8eNAoBmfNLQJTI12V/SlP1y6YOwAlpoNnHgsf9I4+cb1Y/0ZZb8F++47/2CTu
         hn6AGS7umuXwex6LlrPGchXtmTS6stxFpqZ3uUVHn9W63WLnGd4I6l6vKtXk1yVWiUEx
         xRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lN74wz2trhwCCnebKy3JuMypqahD9kpKkHO8XGbZ7FU=;
        fh=b1ALMtowweGSm4PIMDmgiYCq7Cg6YSjSJGKU7NySuhk=;
        b=Y1dYA/5Il+puQdQrh06PX1pseIvNXeOoZiHlk8+fNaJc65L8/6U7JJnAxVgpOeqYTE
         aLlKusDhHaxDzlNHii4x8oUjxKNV0fxGXgLjMO/UdTE06PuEgKXgi1ayn1pvkV6Nx2wF
         l4pUfZ9oox/5MUUpoqAC4TxFh1cncAUxllcuRddRjRB6g4PvfthO9QcMc8nPEarvPMas
         exmtZyCArZzqgk9r52Dhp+GFJwJbwX+qL3HHQXPVmZKruWbie+G35m3McjA6KFrSB6jV
         3yU7YMl+F9UfmvErdREAuy9Kv/4BJmbnaymRMuaj161DK2RIpzsXjgfm+WjLnUk2gzwa
         vPHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777054346; x=1777659146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lN74wz2trhwCCnebKy3JuMypqahD9kpKkHO8XGbZ7FU=;
        b=mkfRPDowIpIGXjE1eHvc2TAtRTEL7b34noD/j3eSkn2HWIkejVX621WFCeEf9P6vF1
         S8VaoYGNS8YUD41UWl3UOq1s2v/eyTUaz4cFMOaDhlU/qnSmf4SYuRv/3GFe5E4E6NTV
         bBkKBYXlw7goTaZQxYgV/Zj8JFc0UCQHCVW8JU3QorbgaS5YCJxlZim2SZCinw2/fjZd
         KS0clICpmuZ9U6TYuiHBa5ysO4lbNowu+pNfycGCj9y67imnw9HQz1Qmswn1I0plfulj
         dPZptLudzNOWLGDMo5Ho512rB9bBI8Itp5WXvdoUI5SogeP7mebLX/Sq8tUESta86335
         Lhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777054346; x=1777659146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN74wz2trhwCCnebKy3JuMypqahD9kpKkHO8XGbZ7FU=;
        b=UWbn8ufFTk43Gzq+pNm8POMjuQ4U6v3gFeuoXjnBJYJXnmUCXna6a1NlNlcyLI+eta
         ZibIAhGpJJZi9xQVF+y832fbon9EBXY6AwKcxiAIUh/9Nxhtk8SXPQA2xED6rWE1I83j
         MiLwXndzzwIhm8kSRrLedTPI8s+r7lBIKFlrLdgVQiuDZ+lDCDKgavc/d3k9xaPK0FdL
         QAxQhs5LBDkBhE72FrrctkTcYv74TkrjnWUtSVU5Jg0BTuouzAhQVPaeV+9kpMUtSf8m
         tbRscejZwm4Fqsfbn/UgRBaNZQ9gZl52wBS3fWV11ISNw6u6n4MbatHI7pQPOP1l2zMN
         YnkA==
X-Forwarded-Encrypted: i=1; AFNElJ9XQ31f62CxQ53XaNHoFK6WJ7qsGGvhvCPQJmR2ieG8R6r8h0ZiQ9qnwku9sSw30aPnw4fmONBHRl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0vJyJa3pAcKou1axnNBsGtAasJhFxke4w4x/U7Ka0llsDZ9e
	/j02qNP5N8Im8nBQQIr+our1LA0/HmZS4Niqnm4lvYDQWQX6zfvbhSMJvmxTbNL4dBj+R7HQ1lr
	EyKAOodIc1omwM+5aH2yPKROntU5wVkQ=
X-Gm-Gg: AeBDieti8S59cdmPl8+6jYIitxQv93uIaSNHL5F7sZ24JaVSmv7o7R6V+ZaiWeoW1I2
	tug+zAd8LBngvv7KMZP45ncU7PbbJWlPuhPksAmm3vlbI6KvHSAF3EwOMOcuSv+zJlfCAl8OlsQ
	nApEu7tPQLTyKqSRjjvfNXgzy2/KUgGGocHF6rr4G89Wi+EkpaGa/By19rd7/plZ0Bz4+bmpMug
	L9K/TSlwYrDOSbAZ8bL5QrA0B7LouYTUtJIoQtVKFH9K9HIqLdHsbKl0W9JGeMHxZCESbnNkO2L
	o9qElSzIYcOz4p1Tnl2jmr53/8ZkCILdHZuYUwihRgMcQRv54j77L/zZCeMuHUgVTguFEErYWn6
	AFzEJDN46rkeNi8QD0Sp28G9q8SPkh8AGkKOCZ1kXV7bvz8Ef+j+5hbugsTJcPuFRdqT0x4WgF8
	QrB8EaJNQOxTSUG1QMeQOThK2okYO7s2q59igC3JIJ/rV5NmimLvHVFEoTgmcp
X-Received: by 2002:a05:6000:2511:b0:43d:76d8:5798 with SMTP id
 ffacd0b85a97d-43fe3e0db09mr50111393f8f.27.1777054345689; Fri, 24 Apr 2026
 11:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
 <20260422112207.1313-3-joshua.crofts1@gmail.com> <20260424185800.6038af06@jic23-huawei>
In-Reply-To: <20260424185800.6038af06@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 24 Apr 2026 20:12:11 +0200
X-Gm-Features: AQROBzAXjsZG55efIrMTFpXhne06hHi4Geb9cdZMviwpGnmKgAFjtZkNVVnvioc
Message-ID: <CALoEA-xbxeZ68yDZP-ZeYG+4qyeeJvcPZ_rdDvNsNeusY5otHA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: magnetometer: ak8975: remove unused headers
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Apr 2026 at 19:58, Jonathan Cameron <jic23@kernel.org> wrote:
> Patch title should not focus on just removing headers. Maybe
> "update header to reflect what is actually used"

Yeah, I realized that it's not fully descriptive of the actual changes.

> Otherwise LGTM

Thanks!

-- 
Kind regards

CJD
