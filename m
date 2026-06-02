Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A832340407
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400867; cv=pass; b=F630NGCc6kqSOO9oVFeHKLGvnwAxoXlu7m/3H+kIibia8+i2etDdRROMBwLAEuk7HIK8tlEHCzvrW+mYggU+rMc0mdjwQF29FZyHTwUBFp/xgPfFxl5dy6n9tcCHdTC8dP+wt1p741AtW8J/paFozyAkQL6BX/cnee/rdoPd5A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400867; c=relaxed/simple;
	bh=ia80s/TPDIDBnVGNZD0BFxErJJl6QIBJJp6uFXi3N4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFN3coKy7dtId3vCDyd1V6e7ZElcksq1eLBF6gNUSPlr4fSBdxvqkuH+OBxPAyMDmbiuiKQP+reZEwLD1y5LBd7a8F2MjQ2CPMzlXDAABO7lHuyr/O6SXqd0a+PkM8LgItgOZaPjNXR5Or/OjnHKjW87HkjPNDuzct6hzFFAsTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3W+FTps; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3W+FTps"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso13968465e9.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 04:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780400865; cv=none;
        d=google.com; s=arc-20240605;
        b=RHDBlIzrsh4VCIiNQMcn6qd4+e3+AQY6i6y6ka9nKv+FlD4NMCj9oJgSyf5wMl395A
         ROdaiUcnb0+ZgShMJo+Q7NHMGifYFp/JrPobZAEAzJy7uuH9tU6KiMNprbWb9cSdbzPV
         HgxIFdnYAZ5R4S8dhlG8lD8zG9gWEIRMXZiSqm5uafgA+VQ974V+lOTsREMNsZkCe2MN
         lZKbw61mX7g50vcGREj2JCQTrwWbJNt7370cSFGT+108NWj9o8ZPRFwx4/8QqcW0W8y7
         Kdhjd6P9UE52uoHPHWQozvroHPB5g4eD5UiWmxbA7jZmg5TxyYq7gFcpZMyIIbTE/Ct6
         kGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8AwxY9CSp1eGjrFxRthuGQbj9sX7YnjxXlLiomleQTU=;
        fh=Y/5QXwaeOYPaGUB+GxIheKQOL+TNm8CxeQwpw+EEwnc=;
        b=fY4M8ClEylrcJUL0YN2mGnsVVZoALIz0fHqGUWI2a2fCBYFepp9jvcG9hiN2jrup8s
         B9h/8FUCdUYSioI3u76t+Q7GpknAlee62q0g3XYROQ3U66+K2CCXuhS6xJEuaV1Mn/DQ
         bt9bm+umiVaDkNOlN82BVncugsmYxwDH3p8cKkgGbH9iOHFMFcBHjdXXaHLF8aU6s1HH
         Bamn2WliojGbSr7pW3D0pyg7TyLqqAo3Zof8/WAhUjoz17hFyphxDzeuS73i/nNuNPA1
         tH9wJN3hhVRnQ0Zp4unT4Dcof1f4xTwzWA6tmhUqnANSQy9lEWNRrX6NhkOptQAWS8IV
         ipew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780400865; x=1781005665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8AwxY9CSp1eGjrFxRthuGQbj9sX7YnjxXlLiomleQTU=;
        b=P3W+FTpsmyQPfBsaWYG4IsIRdmpR/4JvThM1RJtQKOQIcBSfNga9/lMu6PIH60/5dY
         1eyz/uHF7pul7stMJLo5G0DkF94/SaN5i8aaL6fpFdENmlg+QNxXnEn7kqG/lkJRGm3o
         I6q18rX20/bjRjoPJYNrahp0OYFUTUbqqhrcWq5yasfz6rI6Revf2mrJXzuCurC0QsOm
         NR2GI34FayybhgETgoEvmD6ff+vvKfLJ0wFSOTQh/+xNqmEB2QzqqGh0IV/e5lJ2PO8u
         JNbyWPzkfEyHkzx8VPj8Ey81BUT598NVn0z96wkS9qxdmuVXjJzGOX+6nBNQqwcAI/3q
         2e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780400865; x=1781005665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AwxY9CSp1eGjrFxRthuGQbj9sX7YnjxXlLiomleQTU=;
        b=b4ejILVLp3vZTYE/J6djh2A+SLRMHKKE/ex2dTB/0NleCtbU/zgYQwNe6RS5v3/xOL
         fXE8qFqzK7aUf+FpXGHVAq/b0xgELftSUCl3mT5YYwdzwuobQxmAXfgyDyomUOcM73pK
         Eua1F8EDS7rX5XPpRnteODOFQYCDLOqcr8kU23Iq1XWYPVsonwcId6OaHcFEhnmlM+lh
         Ki9vsXq8/76aEl9MlVbyuDSs022tnL44n11ZJG6chxmDNuvAKanpm4zv8P0FRQvwFWmr
         MLWk1tkQtS7h2RnkYidptBshMfZkUjjtSsGYbQzQWeK1gXvUtFZ0Ve+ssZjAexk+xAeu
         lzXw==
X-Forwarded-Encrypted: i=1; AFNElJ9fEdwPP/i+/gs2y0X3gbnbLmu8YIYNPr5GlcTNSW0J1jYJNCUTo0EjcR/LhlZtF4TRDXtF8yk4Uts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhumdwAGGZlCwMUe+sZ4oaqUczzeBHiGCGjyDsZKSKXw3rKLi+
	e0jGnDKa8zGHxfd/DRSp4ELjpCphLQ5jz4xrlrob2WqLFLGDWIu9h+cfEAQneYkMYbhUE4pxFk/
	VIvag5KhLu7A0Jm4rK8lfqbonlOoniuU=
X-Gm-Gg: Acq92OFfyA0aD3TgvAniPiOXxjMO6PXA7SAVJvwztgnGE5szme347Fm2g+apLEisTjk
	Kj3W9bluZXUx6U0zlN4NvyFMgQJmmyVmX5TAGWryu6eGVpJbMx8UzQd6hvjUAOtXjz3cpMq8hkq
	GDRfPvYwKnhSPc0feTtwYnVHMCiedOJhjF5UI6X6gPflq+pQ/2Y4hx6wIKGbiWeVoOgAz9BuA3r
	YIIQQ8PCuYeX/Os5aXrHfLWBORll42qQa6gwi8893L0QC8gh5VkxIi2u1R++3GI9099cUOGEd4P
	K0KGfAUggj1zNxS2rLzsalxwiPXRo+Z5L0jAAqIkS0kJoc3j4i4ohOtIgb0wax1cQRyAV6V02zj
	ElObFDcfQP9GIgueSvRYviLOP4GFI4d6qrd5YTn5Yc5QLc6ZkY6xp1WLPdToqOqfZsCsPtXImPK
	LsOKUMESPhpEoxzrxl
X-Received: by 2002:a05:600c:6287:b0:490:5429:1513 with SMTP id
 5b1f17b1804b1-490a2901c14mr288813455e9.6.1780400864930; Tue, 02 Jun 2026
 04:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com> <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com> <ah66ljSiIc0ywFC2@ashevche-desk.local>
 <CALoEA-wdakU-Ei2FE3WpGR+CYRDN1bjv2sZ=XJ01ZeH3NP8xeA@mail.gmail.com> <DIYJ5ZACTWVS.13T8L275VHTKM@gmail.com>
In-Reply-To: <DIYJ5ZACTWVS.13T8L275VHTKM@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 2 Jun 2026 13:47:33 +0200
X-Gm-Features: AVHnY4KTMuChhhggHc3Zlzy7ApZijOzq7Mr9kHfu153-5N7Dj613xK76dQ3KH3g
Message-ID: <CALoEA-w3TqD=2YP36=ScmRttmmG3BBCKvtfSqeJL0PVxRxEbuQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS series
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 13:35, Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
> Thank you, Joshua. One question, though: maybe you remember that your
> last driver was missing one header (which I am not criticizing at all,
> as you can see I missed some too!), and I am wondering if it was because
> iwyu missed it and if so, how that could be avoided.

About that - I didn't actually run iwyu on my driver, I recently migrated to
Fedora and forgot to set up LLVM and iywu-tool :-)

-- 
Kind regards

CJD
