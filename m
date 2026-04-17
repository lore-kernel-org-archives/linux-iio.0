Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDD37F735
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776426071; cv=pass; b=CMHt2soYFSzQX7FNqfG0oQ+VYJq2p8vA8JmNCYXbV1C9A87QQnYNZ9PZRZ7AwRorStmMtwE0RrTnSvE4uKxndjS1YnMaFQ6vAMcDXZaVHgu7Nf9Ng3VIjGJ/RDUqLJFRMNhVDXmdFKJuFwpgo+1RKqyiyq8dB/r0lDPHluqvPoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776426071; c=relaxed/simple;
	bh=qE/M7ktEn0N59mdnr1atw8SbEh4Cm/p0PsekrgTMOKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBUkeQ+OZfKTXZtBK3phM77Sd6GUd98FWt5dLwgKer5q1uQXioU6SS6NTkKjzm8dc4TX18nC80FnDTklJCI5f1B+pCm6nWtv/zgwe5gfuy3BxIIZmcrLukKxhjdUjQuFLRpN2/2dn/1G9+IdMXucS7kim2yxmZuHsl/oa020zyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcCLTl1t; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcCLTl1t"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso3515055e9.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 04:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776426069; cv=none;
        d=google.com; s=arc-20240605;
        b=bXyczsykeymfHdX0grh6D9oMwK/V7kk6P4x2NXGqkJdJG1KmtvNCK8WSDdt1w2GSGE
         r3Uo/tT5DVoAwiA+5EG4/qAeKkQYpUpEQa6LhcbSyKWTRj3Kh4j9sObMbxCILaNlnlNT
         cLcm6dGPpE0XAh8HfUqJGZTxHAfFCxD6rOx0X2t1COMjZ6Bpsv2c+0ohIft6POQq4UJT
         f2tYpflwGJZcLCW/M5CNIEJjnDDmKAVxrAgn5nvZ3ZkWLiQ06kFzzyOK8HXQuyrM+L7j
         WmvIZ6gYDKJbKS+TxSfIKK3+p6DqOSAZx61VZRd9+IvLePiI7kK5RU2L0dm+YTjzi79k
         XGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+yrXYBy/QriFyeZcNaaVKwZRLpB5Hr40xXAwGnR3uJs=;
        fh=yMbZ6JKYYZNqUAAIIYbvwmECv5fpg2eCu9lOvG0dd7M=;
        b=G6DoriTmA1lT11BEzVXsc0TFVXEt2jvG9h/dhns222vdtLzAlkK3LbfLTSDxyb5NA1
         2H+nEqMqA7jS113FW7eL5gCV5ZvIqCAonxPSSue/AjrInHN2eUnVaQ2IvTM7b0VEM8SE
         dMb65ly1sJ27jd2+ld1X7fgAdR2HfnrTOHsXkeYETi81pi3Vt83PEOs5blrThBtFyT4r
         rH+tfSmGg/mhOfsKNQ+T+50f05kok+zMCD5xMSjSE/hhL/lj0NcDClvuB3iPnbp3vQOi
         naS2NE2iXAj/DuoBeZRUzJ7a3mTZtC+/qx5gxNVZ4VZxSlXjP4wkHaBwvZha0MOZzhC1
         QiXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776426069; x=1777030869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+yrXYBy/QriFyeZcNaaVKwZRLpB5Hr40xXAwGnR3uJs=;
        b=QcCLTl1tKAbMk8xC4Kk3C6yuu1WiZHIFXcg64Xu0cpb8GLHx89fS+2px9o2+Kig/+L
         TerCsVBJegzHKfR5CqHdN/lXgfllTu7kAjZPuN50rgwQCZ+qMo054nTja5jZ5RBY0EyI
         OQvNo1S106B5AyvVDqjS7ZTNpTABwpdjrhdQ/pnGNylMG4QHfHDSUCSkR5lR+xp5Qnoh
         /99fWwKzVTen+roFHyJSLICyLyihUuwumCo7TqSwXcelgqW8rRtQm/uO97keOjT2JrLY
         IzgW3KY40QboM6eqxs019+RRNAOOiagLdaTBkh/kOWfSwVBsqPTFJJbynSpPNchNJQfG
         1fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776426069; x=1777030869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yrXYBy/QriFyeZcNaaVKwZRLpB5Hr40xXAwGnR3uJs=;
        b=QY/8ipzrGnIa3F5SPjYWTgzwQVvtyewK2GY0//iH7K9pPXstD2ruCSkPwAjmsMXrKJ
         7U6qM7Sy4eHLxiETX3p3J1UH9F4tQqWOxfhA79cut8oNMWdyB7Jvm3QQthMm3UJeoSjq
         N1unbenGbWEJ4OhxE2os2ruiXdhJveBuNpgAmR6sFHcLnPvofYFR0bUd4o3MleTXxFfh
         JN9sN4VLbZoS6a6tUI56IzToQGah4Nu+pTqiM/DAkzvSXOTZ1OfCjY7ZOIRvmAq0N7eW
         Vh8UzvvlSVNgBPLe2e8lfBEFzp1Yex+OH059OdYgB8fhP9kJ9x3hBEhtujXjDHM8ykTX
         GvkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4HbSsBiPbuJlJAdnaV52KypSYpYNE2d+/1RRN/X5Pf5nEJf6LNNBhHspR/kAWO8KhOdONmy2ImZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyAmE7pS/DczsasdTXh2bbzPx7WExlDRlXYBZGwZY7mHxBV4g
	ZMk8aZ7MIRjx1rX03T9qmb63qo+pwyAtxV2nLeS5lMGVtYixwp2bMmWpn1rOZEE+71Nf070+PVz
	ZWBdCfzt6QUPjy7hu2eW0A9ZAgTqC1zo=
X-Gm-Gg: AeBDies6/dvZAH1axvvoE12xebho6wg0Yu2NCqtcKS1F1r6GPfHBXlc1myW4MQMV2W7
	PrtJa4noERTHgTmtjMbwbUlyWQXW3g2W9rCEkGq6/dkF7RAoVWHEb8ikfepqTHM7oCWTG5KkzvI
	iKb4jRv5Q8cBpsVF7YDtXVNv5Pi5u1DnMwWRHxQ228dgqWWLQkci97a3FSTpm+/nNGShVSt1DJh
	nRIbcOH80w8TU+mJRqgGdeOiK/ir53jpoXP0mcsGz28M2FosCtH4NGGvWEObK6IbudxQikX2SqW
	rhJ2TVJI5ceFQUp6T++cUM9AKkVRCtdEgdipizK3TR3+FYrgNGxwbUqjsNcDjVpi5bNYbCh5Uhs
	1FGC7pyIGPHGffcXexuWcWUb/MYek2fd7noVOaOcIs5mYw6rmmpEvNrxetR3pTkBXqnP04dcrFd
	etla45JF6HdV8JjAcw
X-Received: by 2002:a05:600c:810c:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-488fb79567amr24359695e9.29.1776426068797; Fri, 17 Apr 2026
 04:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417112808.1280-1-joshua.crofts1@gmail.com> <aeIajr-NaBGdhvK9@ashevche-desk.local>
In-Reply-To: <aeIajr-NaBGdhvK9@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 17 Apr 2026 13:40:57 +0200
X-Gm-Features: AQROBzDY0XGmZFVB4m_-CwfXO3jjob3O_F0dI1q_SN8S45oIFW4dQRs8kjENFx4
Message-ID: <CALoEA-zoEgCpzrnXDmwCKOWFPMF3p0C+rhxLFw8mLq+p-HFG1g@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: hid-sensor-magn-3d: prefer 'unsigned int'
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Apr 2026 at 13:33, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Please, use the same types as defined in the respective data structure.
> https://elixir.bootlin.com/linux/v7.0/source/include/linux/hid-sensor-hub.h#L87

Fair enough, I'll send a version using u32 tomorrow.

-- 
Kind regards

CJD
