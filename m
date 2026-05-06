Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BA33E5579
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059813; cv=pass; b=EwCCH8gVP9q9KbVyle8Llvfqco7gTj0LFzjQNN3Sk2JWdvJd5RnxGdZLe487vq6CmrnB5Dks7YCnwPbK/BnE8qWamozsIU58ONZC9JVoT8Ov0OVR6X/PmKdSkmAJw/Lg66Cg3o56s1Ck6zoMolXCBwhkegY2q1brPuXGKKZ9X1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059813; c=relaxed/simple;
	bh=TrI5SPT5J/m7D7W7QD5hvc7FAmHkgm1V3OqRExRysCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hajcXhObJ5Qaff+wAJix6xGvvPKileOkEdw2kuZr9VkmMHLs2RvVK9jo26DUssW2T1huPs5J0LaoS1NQE7AEzYPEf8maMMjJ501GDTcZhhzKMge/jEZ4YcOKyMKQYiuv52ql0ZuYIblBO41B527IO8JxD/6RxrLZfWw/5VOvALQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKvT3DMz; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKvT3DMz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so88475795e9.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778059811; cv=none;
        d=google.com; s=arc-20240605;
        b=MaOEG8bm5Vkc0cDSD11rvguqqipVZ3IiGDx+dFdSrb20NZhSjaKNI+ohv6ag+v2qrB
         mVCcWYR7HgmP3ptCh8Lb3GTErGM5J4cBAkoFGLKmvbW1zPbKHeyUCD3OMjH/qAa3Cmym
         7DTT7pNZefdhOXYf3Dr/b7kOOqnHBahIN4LaeKq0wTig1LnZGzqZywMDBvE9kH6pztni
         /Vf/FCLSe2JC0DTEeKOb9Q+A7ZfKkNQvK0aVOdPa94ASIxO3Tz99aDBxK8cgG6jhd3mc
         7uDHzQBcqYJyx4rEjw3QaPTV2/8mxd9UcorfXBZshh110ZRbydVlIQs8/DqLvwQcCCHk
         41Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0GmxtZ86YiAR0RPq6AMncsaXa+Cq/z0S7MyXzG4pY3Y=;
        fh=Hrzdyp2Ck+Fkr3ShE9FGaTHU7bYtnrARJdkl4s4b2jI=;
        b=iljCy89Iq1E/czHNW25AK1OyhuHN/TMqCzlSPchwJEMn0R3+P6Y4MakvFH7xn2uhwS
         f3RG8evpwP+4TOxetdrKvMr4HWZMhXPNoQOM86+rCWzAY9WNqZxkfDutHBzeOr/Kois/
         hr9bJ8Qh9NVPLfa2arjM29HBjW9Lqg1U2BOYLBs/7NmZMspC0OYoS3+bRq58jj3SH8pG
         t4gGQEmAbIJDsXzmbOmhXrinfMWKbCceQwY5lt5JxQ3VkKvVPT5Rk4HfN7XNbkHyfGIz
         SDZ34cs5Rg91FYmY6E4OiK4of4rKsii2imf1vKTHM5zzFdjV3Y+iM24ief6qA0tYg+EN
         7NQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778059811; x=1778664611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0GmxtZ86YiAR0RPq6AMncsaXa+Cq/z0S7MyXzG4pY3Y=;
        b=bKvT3DMz5RQPOQKupLXIyKh2qevaJJdy1ipKsDhpZFLIFHOFFAHmv3Y5H/gHvvmoST
         fptnlzlvusRjwDLxZheDPwnpnfGWNeXqKcdbsNK+s+2h5n3NyplyQ2VIrnaCvAr/GIMJ
         mq0nnWYC6aut85EIaQG7Apb/JpoQhHai5flWM5UFW+k5g/quRoc6nb29KoGLlN/rPTU3
         eWEzE7C2JrhA+wD67icvARLkdzAC7/OU2aJj9dWkw2lSOj8WgPoeY3UYQuisvTDj/FKQ
         tsswxK8U6O79FxSpO3ZBlDDM+MXqub6Qc9+Gf/aK65C/G/LaLBRVPGoszcGAz6mP+ejR
         jhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059811; x=1778664611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GmxtZ86YiAR0RPq6AMncsaXa+Cq/z0S7MyXzG4pY3Y=;
        b=HuF/IOfuxetz04dYHLS/T2UwlBNR79+3pYeJcNlNgvt4Nu6vjew4q0xzjY4r38IXdT
         BWjZe+AP3I+qu6w8074FxKz4tuH7KmOvFYaHwGOGKxn0hlKxuu8NSuhSbgsSEhFLREIG
         gaAatZGvD6qGSwHqaLSlpBvYT5+A4H9tRTLnmdh/G1hAkN+ICVQKgRuNclidtwN8R1V3
         Pn6uVt3qZpWKC+r1uoUEHgG/hCp0oNRTfuWXGiA+tSw+pdn01S+gIYAf7ILn2NvbRQqQ
         38EIGRCJsEZJcdiMj7RMGCC5VANUvLMFu9mPN22S85Xl5979cq4OLn9bgYCZhmGqhsM2
         li4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+1SHOdXOrDIzFxl9rP2qM6m3wJUazGcbtdiCu3s9iDc/LXKqz36RVTzLvzdS2E2BeSXKfDN7ViHZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIjRAi3w1VlDY7Wu5NvDfNy+V0vCBd+pr+k2X7Ozeg82MciWu
	BvRuKa/A3/Ta4eaBEXngXKueE0BEVG0vGaZ5E91+n0yZhsAvOGTAUrWSa/BFDV6gE3m4NTF5keW
	C5bSJ9UAz2Nw3Eo8UHlp4wvF6DSR2RwA=
X-Gm-Gg: AeBDieuoTB8lCRtwgPOL7FjGSiN529F3zYG9s/pzTdAOCR7n2kQfx3icladwuZymrNK
	e9G9LC5me35l3K8wsyFIfFAUPR8cFRQWjcc+7yrK+QBLhEhvzx76u2g3zX9BlPzDB9zYHCPfZ+0
	ePWU6Rfa93T8WndmprW6ZOspRXGKcWzVv3I/pnzmTAt1MnIBDkQUIdife3i6QYgxDyCMk02v332
	PjZ57MxrBGCqzKRiWZzkxUNw/U3btvB2BNMRise0VkV/w4scXt+ZXrHn6gO18PvSCqWUDx04Tt3
	vwUjtH6IVHEgDvNFmxAHJykU/daXDtfx9BRktAiitR5JMBebz45V9xC7f0/N0osUFemkEzlMTJm
	LwOYCrWrf3SfI2c/jVyvgkdG29gxlFtuR/KNXb0syUgpiZJofLvafTvCWsT0Y79GJ/xI/F74BC3
	RMEROQvI+MLQCaVUeq
X-Received: by 2002:a05:600c:3b96:b0:48a:66a8:9981 with SMTP id
 5b1f17b1804b1-48e51f55272mr49117885e9.27.1778059810627; Wed, 06 May 2026
 02:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505174640.3998281-1-sanjayembedded@gmail.com> <20260505174640.3998281-5-sanjayembedded@gmail.com>
In-Reply-To: <20260505174640.3998281-5-sanjayembedded@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 11:29:59 +0200
X-Gm-Features: AVHnY4Kb2jKHyVCvb1cVKg90ExRji9WiRoHABNyirF_9_FFbK4AP7G6cK1V7dIc
Message-ID: <CALoEA-wYNLdsn+pdH+STm=ym=cwLi=+Sh0QQK=Ap1z3qYdcpiA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] iio: accel: mma8452: sort headers alphabetically
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, sakari.ailus@linux.intel.com, 
	christoph.muellner@theobroma-systems.com, martink@posteo.de, 
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 19:49, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Sort include headers alphabetically to improve readability.
>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
