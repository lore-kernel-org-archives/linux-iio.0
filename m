Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794869477;
	b=EJ+qNch4E6+TDYIQtiK7Cr2VUrLJadWB9aPi6mSG1RCcHwt89/pTlLfDytBJ6LBRr648
	 zFB9DA93gBrsgcowoQJQF1sXraffJsuy+asRTdqWziTc6JFE3kZF/kWnHW6BIr557TQf8
	 EPrDULp9zQt9wsmVWTP6Ff9gN2BPe43O+DabpUp+V1rrpGcF9upbzk0/KXrViZ+YUSTxM
	 BoiZ/HZkE94s64zx21WDA05SVoxLaB3Yn/I2DuIy2wevs3kdyQLz/Ah7hxHf7be7/6O6W
	 vAzvjKUmfcjbbr7/qXDd7NroQDDDY5q2/WXqJ4seMeSyzwbSW64blaNdYA8TYsEG4ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
	b=LdYN78+zGQMJ9tcBLvfQ4lVFvBK0INhu9xbyyzOtfRN19+4nHJ9tpPDoO0ldRK2jjinx
	 /1+X2GzzV5wp/ZhzIfBPqdWUWtY5IsjFcmgm4JoPbwz6hXtwU1ZPv5a1cMi6S1wsEfoOW
	 ByfWRyyHzjCaVt/mGhQOi6eFT0GEsgcxRZd2WRS2k6zm/62J1nupTEMYaxVSNvDiHOTU1
	 A7FoQQ+Z+tV76ueQ0FPj8H7LPdr7hSemu5UyjeAM1zQH4p9v9/9lBSFTW3HAyCLROdENF
	 nz0OBS9SxzXse2Q+LmBR6++KakTfjwBTfBnJusLckLBmFDOPsEZHG/Nv+7LgkpKcz0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kk/p/EUZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACED606A32F
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 22:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ACED606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kk/p/EUZ
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14f7768acso3278180e87.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 14:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794869475; cv=none;
        d=google.com; s=arc-20260327;
        b=YsMpXaISsdK4LJOjVTvJzKlEmPtnljahWQa8kaf5kyxGvdbZ8YpelUyu0FanoLnXd4
         nzR8Ui6oK8o3ngg/r73jFz5OrwzjniVJO1UFLYNvLh9BLPs9Mc+tc4pLRqrUoC8JK56/
         FwtC1WwaLaSCPBBxYeXKX0HO/wrH1UzFlWQjq1G3KSkTi2kd7IQk1wUM4aRBBpnaQd78
         fhpQsctXvEFsNHdWrJrcEa/Rs5M2DGFEcDLq/bvgWiuaVfDwM3KIxECgbAjth8yUrjBL
         0bkfZKtMbJY+payI4zLLnDjcBvzCrk8oBKIxtxtrorSfQV1tGXGBHrXpj89tjPtfWwg+
         FZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
        fh=XsmMOGsKUN7fvE0cf6t3s6EeE3db1v7nYMheUJJltMQ=;
        b=iDUee6Yaw1uI9zx+894oTPzT9hXxa7RAWrYUCzvv2elc9Y7dZXj2G/1cjQnflLFjWA
         COzcAco4c82jddOa98kjaV33Z3KKPk9bPWot2NOlUAf/Ac/0NUa9ECsF0XKo/NAmmN9/
         RT04+aINck4+OFordj+SF53Ly+idrOOZ3hxRpEy343w5p1uddVZcSOuaM/JceZcghnS5
         eRkCSklLVda2Ov7Nfhq87NIHuMOrXaVmn6o0dAm+aQhlThsTUZOjNNFEMtv7ypGoAS1M
         UXAQfeXaKlqLpWfvBjBuITpx/TLeCLnG8jzdfi0TYBG4QQjjebc1YifS/LP5KcQDo9gZ
         UFfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869475; x=1795474275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
        b=kk/p/EUZ42VJ5YgKv1Wn3i+cPwj2SErCTRW7L793OJ0KFsNhCm9BuTgxw25M436hxE
         V+gWlsQN7/eDt/WsiMaip+OKOnsd8INibpn5VjqY0nM8LEycYyq8fhFtSzsxtVa09VYI
         mX1qReotK4FksPWQDUjL98HvDzHNaBfLnKgBYWSR17ox+RhuSN+LMYvEsxJvXJH2IUHW
         BHmkCG2FVqHRuiswoAB0HnlpuNtJsPDeRalmZzkIGnNMdhEtE/lVhJyBu2SepnE9Dqzb
         wC2kJSVYH3Y1/rbV6xzEoYbWB7cHhGoewD2w7T2axTp0Mv+VXe4PGlgaLvzVgchabuwg
         wldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869475; x=1795474275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
        b=knWBLpdvmIuloCFSWRXyvnoDWqLt5QDKGbBxj6c7FjiArQn7v9Pcdlx+94vnV4G7la
         54zmNG2/xylhK9ADOWGVMJus7EjZ+dj20sRDwFX2dqvMgRSA19Vav9OWhkb/BCnJNmRI
         8pKOYAeUX5FzyUYCSBiOHAAi9xLA+Goum9sb1N3S7BZOMmvrgrIGZ6baVbBACU9nveXQ
         yOLnl82hZ7CdOI/Cf6wrzh4UxBeHCcmOuaX57wiXZd7MkCaWWNnY/x3cWSAaLLcsSdf3
         mMQv+FCCtQjltE7kArYkWTkNhYYVJkj1mRvwnBLBfrFnrIkSVkIU8bwS3Yks9SsSYLD1
         o+XA==
X-Forwarded-Encrypted: i=1; AL+hErGqqF+CmdX88Y+j87Sais9Za264UT/H7Ok4T/2GfyvMMSQqISoUzZsxNqhZwjvXiWl66KKJAzYbFaU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dfhRKAaK5UtTZvygFIJawT/77JDU8nQfSdytBbBCVaewwNhqv
	5a4eViBtJ/VCaiP7bR+X37BMckdJIg4dchFnQJB4b8pvkTWa7dV72QYXePMgGVpfNqdlmtpQgvR
	BGG6dlQTPbT9hHo0wr/uX6t1FAsLq7y4=
X-Gm-Gg: AYBFou1pkFdWNjfYZeW+kEuKqWToFlz0cImihSDfvECtiLQV85DR3EQjCHUVRBWUS7P
	WP6Nvk9y9dt0/TdN7MaRynazHrZn9sGzz5CbjLZ5/uleCQpM1Rg5MUIjo+axWL5PNLGfVzV2ucD
	5WF000eQvorhSOlGVFj7TdaAOlmcfw34g/DqVen2wozlq2nddp13vvURSIhP/Ee61j1jGM/evku
	SO5WGBK4WMBf+46RzLHGhtuKfHxKXlcDDyptfBcauiigy9nmxNekMcpEYc2HfZmeo05RaZK4/e/
	xCix20CzrXJuSUTIC20UfulW37NyFV//0hWNRbsSbuqVpCJ3qp6pXzJugpFSF0BwIzAov/H3d9j
	2pwCwMdzjqhsHMTY5Ck8+MmcLhDLVW4P4m4jINHAk53DFRcwVBF5VtzciuCQVwVD8yW6FyXn3Wo
	RKiNZq3TL/BTHyzkLJHw8lkMVeug==
X-Received: by 2002:a05:6512:31c3:b0:5c1:4f6f:564c with SMTP id
 2adb3069b0e04-5c1709c5b64mr4475988e87.39.1794869474886; Mon, 16 Nov 2026
 14:51:14 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116224803.61154-1-festevam@gmail.com> <20261116224803.61154-3-festevam@gmail.com>
In-Reply-To: <20261116224803.61154-3-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Nov 2026 19:51:01 -0300
X-Gm-Features: Aa3M54oXe-IAn7x15degHvby6uCIkABaEwDsnl3MJEDi4r1Iu6Ak5t9VY_ssJ7s
Message-ID: <CAOMZO5CPym+AYFLv7D-mAH+OQXL_83yForV3GaSk4ReT_x1HrQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mfd: mxs-lradc: Pass parent IRQs to child drivers
To: lee@kernel.org
Cc: maz@kernel.org, andy@kernel.org, jic23@kernel.org, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, mfd@lists.linux.dev, 
	linux-iio@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 7:48=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:


> Changes since v4:
> - Map the LRADC MMIO range once in the parent.
> - Share lradc->base with both children.
> - Remove duplicate child memory resources, preventing the unbind use-afte=
r-free,
> as reported by Sashiko:
> https://sashiko.dev/#/patchset/20261110141934.42490-1-festevam@gmail.com?=
part=3D2

Sorry, the correct URL is:

https://sashiko.dev/#/patchset/20261113013212.470981-1-festevam@gmail.com?p=
art=3D2
