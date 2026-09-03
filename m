Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD394756CD
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465898; cv=pass; b=V1Bq/HufmIH+rsj56jeWxHU/ZHzq8tOzLtDcfYIes9kAWI0Yu+7+f0TsLB9qj816DOjja84VUmmlLYbWDYW+Dz5O3varx2+0afrlxFtXYxYfoEqojN7+nvIdWVfCBxwjyRA9395zArZr9Jtf/lVHgMlHP1E07OXkuf38O26MtkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465898; c=relaxed/simple;
	bh=jOv4AdZM/sxSh2PLGWFXcdhUFav4H7IQM0rmmuYkKh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc2FIAn9XT/6S92Prolz5/oF9BWw6maxwGVN68h1ZAC4n/oEgfuInRVYWJgGiO2m4hUEPDyrGRSe4Q46C8Cz82oyuJf/0tnt7Ym/3Zn+ygL8zJ8FeMyzQvDwZkWae9LBV02n84E1nSsd09TGNqaSZpB/IeaqKGSvm6YOTnD3DXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH1Vz1HF; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH1Vz1HF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-395cf2535acso266341a91.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2026 13:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788465887; cv=none;
        d=google.com; s=arc-20260327;
        b=h5A2Bx/+MmTdKillxwDzzZVCUjMZtBx2juCjNRKzzUYRZC+6/ig2saVwuQttL4BpaU
         GWX3tX9UY9gMegphtWIb49bXX6IaW7BuyoQmYmYM6T7fsKgjyxNDxu6SCzc7HaNISihB
         x9vvJ2wcEFA86xJ83Wp/rUqzgypJpba6jG115Oy2SxGMJK2HaW44xZycjSGqtydEIGx5
         81KW+lAJOf1/S1uzz3nsBhfFtHZa+zQefNPhjuU54pisXk/AE9eT6ahvEQuXDRxaKM5M
         xqwcIaR+Sdv5UURZ8uXVfP6do9M80ZDIxJhI+XGM4AnL25D002rhMPuNCx5uOnCLDgUp
         kubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jOv4AdZM/sxSh2PLGWFXcdhUFav4H7IQM0rmmuYkKh8=;
        fh=FeB4B0wlg7deUb4sxfVV0kfKT1tnaeYpwCbqaOlVIec=;
        b=ZV5Gz5cN5DbY/E3JcF6XIK1BTZe/d6FPimAFuG21he3USby1mzW4HdReHuWszoC7j0
         DmBBkqkPeWTB6zmKYJ9Prsh/RJS2Ci0Na0XdN0XsVtwJv0+Gc4CWForhgv/FxDWazgCo
         b9Ix/zT9JxTLFm1Tt6LNP76XcVLjRtRWCoFH8AnfP+UJakRZBv9stH+yYFEvYIrJpMfz
         bBHXNM8f4TinE09iN02OHPMCyW007mwu4gxPgVvHlzKUhlZasAnBdjHZOljVqH885k96
         jzP4syOW52uUxAXwTF06uV0ZgIbpvUos6uELQqo6TjolSNq4+fGiRPZrp911PYHbDMFp
         Yzlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788465887; x=1789070687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jOv4AdZM/sxSh2PLGWFXcdhUFav4H7IQM0rmmuYkKh8=;
        b=eH1Vz1HF1tFDsSRF+gHl4jsxzipFdAYQOcLQnYu0ZSW5epYSwc5//alxCISaGMZ82v
         wO5QTHLxtY3viUDvRJZ4UnYr9cmZ2izAy7kVvNfixs6ndRi6IMmVzzrRY9+5e/xRvhgQ
         C5e9HQkCTxj14XJAiCDLiWoIxzS/rv83EJn8cNzIreAOin6sLL/JeQNkWPIqJ6SCT2qp
         gYdZJGWZlST3zcjNmovIgFo+tpc8v0S84JYBS9LLjYW2jq8lDB1lq542MChjtYukGF7O
         r0p1JX5ff4/eMrJiWgcFhizDQLOCXum8Qxu7+Vf/ngfUmdldb7MYFFM7o/qvJA4VzmXg
         gP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788465887; x=1789070687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOv4AdZM/sxSh2PLGWFXcdhUFav4H7IQM0rmmuYkKh8=;
        b=J3nBL5yOpSJGTv0c5njYDguR5+Q7eCSL56XHy9LEFkli6Hbm+4CnXGgY7sXMcE4r/g
         LC3Gz6HZuVkenysI6snKhCvG6zWb41WZ6eggPsIc9MHqtJ435E2IFKHCgHj+NLCvpOtA
         y9aLTS9uqSnTqMmSL9A3dWty2DhOrqxR1tDRxCKuekOvzwfUxxGPKxDD+nmj80qhY9le
         bPutB8tK+n0ni24Fg/qioWk6Un18v0Lj2wQk/QcKbcpvQBLu0Ro2lADvSfiq3/AJvEVU
         VXSPSngH7IqQPIf3XUywJyYhjqdxBbS3yKh8NxFAem3HAgUcYfjaQawYg9yOPmHABklT
         cGMQ==
X-Gm-Message-State: AFuF++nvOtwIcTgGpYD6352j02tRfh/CJJmqHaMRzeAdpwD4C5fGEmZd
	2WaH4wc2A1tY/zl/+SF3cpOuBfU/fPWWgcUqmviFZdlSwIww7JHlPcBMl0ihByhrLYk0hp/RJqr
	mecJJbHrUCTGVWkOX1pejKH6iEdpMGEg=
X-Gm-Gg: AYBFou0byjEmjVOhA5gm1CqB4pq7wz9ezY5kRqUpEX8SM2WBZMsXpraA6X7kXs0hwu1
	9P0JZmxd+IvNXTJ6NdlljmyOdlOWA5hCXpEo5BT2+GKQ8fQ/JY7R6qqm0HeJxOl4auuK25WZz1d
	0pIsd4PCqSb5hZ3bKtUz3vKg22nGyeIyzIXbZ1jUqe+8m7BZBcTpjVZKTk7EwmQ1ZDtG9LGzMmX
	UnJditZNQ6Z/+PYwyxdd+kodx6mQ23JEc8HyuQ8yt6QkT34iMVvnD1iyOiPXvOGrNT33tnVartz
	MI+hFU/2FnuP+fLKi/XevKUmcBo+PwHWjC3r6O8BM4Gv
X-Received: by 2002:a17:90b:4490:b0:38e:42f5:d096 with SMTP id
 98e67ed59e1d1-39b279ad968mr247148a91.0.1788465887300; Thu, 03 Sep 2026
 13:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
 <anocR1F6uCdh4e1V@ashevche-desk.local> <CA+gq5JgkegYTNKD1dPcWRp9sYXoMDfa9O4=B2azROy3QuTszpw@mail.gmail.com>
In-Reply-To: <CA+gq5JgkegYTNKD1dPcWRp9sYXoMDfa9O4=B2azROy3QuTszpw@mail.gmail.com>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Thu, 3 Sep 2026 22:04:38 +0200
X-Gm-Features: AcwNN1Vm8_ZpCnd10IaLPFM9kTjtcoDvTkAZD_zAraYSV69m1vixkZprKotZWi0
Message-ID: <CA+gq5Jj=bMQBFr+DBZcA5TUPYC5omEh1T-A8MP3VpOJ7XRmf-A@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] iio: adc: ti-ads1100: Add support for TI ADS1110
 to ti-ads1100 driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mike.looijmans@topic.nl, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jorge.marques@analog.com, 
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com, 
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org, 
	sakari.ailus@linux.intel.com, linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > LGTM now,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> > A few minor comments that Jonathan hopefully may tweak whilst applying.

Hi Jonathan,
can you check this patch version? Should I resend it with fixes?

Best regards,
Jakub Szczud=C5=82o
