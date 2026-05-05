Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D024921BF
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002420; cv=none; b=Alp7P9YPP/P8YA95V/R1G99AiKID1wl9xhjvkqt/N1i0vzlmnWwCHtm+riAEOiPr5QX2ni779Y4SnuV5dPDWdnaarZpJkF2bJOXnneeAaNfwXb88xQRpwVVTUawwC8lD8qCUhZALnQewz0Kq8Ji06fBYMpj1QBfXg1ubw4c4iI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002420; c=relaxed/simple;
	bh=uoR2gEbxq22hMAQZCudxu9N6ovIXDpq4hy3MyYXNJbk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=STNNoeCXWqC9cUen2ZsbRZ185+N/69SHGW/rPNx5SN7RsQaINenRIOzXnuMq+8mT0tUchWHJ7OwBWXZLNwAaY3JxvjZhhkRj6yk7AFdjtR/Cmzyj96BQpkW9JE8UG36DtiiY1kL2yaKf8+WFQZiSutcIZj07U7P9voPktEBj7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItT00jjT; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItT00jjT"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bd9f61458eso16508097b3.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002418; x=1778607218; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnRe7KjU8veD5ZITTDKx3xTk0GWaGR/EUMVANxzWmCg=;
        b=ItT00jjTqrnjZjm1tvXJD0SR5CA7ryf4Tyw7Lm9JathECfj49+KEsCYup+0VvXiZ+a
         j3awoNSmHlcKe65fW82z0aWlcZXIVkOs0HhYtfE810rOIEPqzCCbm7NvxlbC2uZY8/2Y
         kiibfPUxHmfEvdseV4wXD0pgV0mPXC4OhmK3XA4iMc4/UTcTXs44T3MaOS6nHrWLT89u
         0kZnffb4ymUlhQVv+Qhg7xnVWj0RNEesSyIUB9Fv4ut3gRz+oOVwnR+AZ+zu8f/IWSrz
         Lqz1rtA4/xeAgl9gs5js90s9H/ICN6A0PClehM1xGF9yokV3PRSv2fErZhRlOekeH45P
         5grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002418; x=1778607218;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnRe7KjU8veD5ZITTDKx3xTk0GWaGR/EUMVANxzWmCg=;
        b=RxhY8TlditSxMZXPm/A4djPMR2fvXBTYfTiWfOCMi2oFVlOZXNs7aQny43ZItzEQKz
         4fHf7QeVL2t2qQyto1nMuNxgrDuD1cKMtfVnAXhcBqqR3DZXFmTG7WLq67gD6ALsd+dP
         Hn+k4fgODzGjnULMIq2trmTEH0DDLDAQCCH7pMpTSiquXF+3dGCOa1N6oPtuTLpwqkNp
         L78iJAojTx+Av5bEpgoLvHxW4RxUSgCVmWapJ1iRtbs5v0ylRtGCCMhtulOzxWvGmivm
         wk88elC+g7ckuqKv0XjqQZlkuMAD47JbMpO0WUUOHLm6+YSu+iJ+MfhmmRmx4viXOBZZ
         wFkQ==
X-Gm-Message-State: AOJu0YzvJEMlYGJ55Sws3cE+cvC4eIE2bAeQNIcuIzF5KxPW4TysU60y
	TJvFhbWp/nc6X6DhbLVX53AdgIIoHualihA2J1wGV0ByMCjbe8VsKcEJ
X-Gm-Gg: AeBDies4HxZiuZqb2SrStsqKasYVTNeF7N5mI2vjmanHu6uk9PuuRkqLDiR+7l/2DLs
	2jjUgTXUNOWWv+CsDZPhHmY9r0CbbEhUrh1VM/3RsDrDUPSgo5yjLJp99/eJqLz9orSWiVxnP/W
	JxkIkZMvGyDZVQC0VQAJnY4KITMBMbBDtxpkuyVMdGcVRSRCDfbEz5CPjVRN7Hl3B+gIqg4oB2q
	dNUhcVpqvSmnumrWJl9A2a2gVcbUE7hTy5wa/q2fY9Q87mADoWtszX9Iqr6uyGjp/IimK7vJxBq
	zv20PUijniaG5PuYC5dlN5ibSxikqjBZ6EARqGtZwtAvBL0/CYJ5rfJjHE+mVA7DANRi7xNVBvF
	PdzQV1dYz+AmStzDcWTLtOg09vyThbk9n54yhW20P2QTgmWPBqgz3AqErZqMy9oXCMJDWUWpX0Z
	WkB9srqPEYvw34fpiZgrV+gBPCll7fciID8lJMLZtdcIKHmGzS
X-Received: by 2002:a05:690c:dd4:b0:7b8:f152:7545 with SMTP id 00721157ae682-7bdf5d8014fmr1543767b3.9.1778002417748;
        Tue, 05 May 2026 10:33:37 -0700 (PDT)
Received: from localhost ([208.185.137.148])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685d0cbsm66174187b3.35.2026.05.05.10.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 12:33:36 -0500
Message-Id: <DIAX965B07NK.16AH0B7XEZSUN@gmail.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: humidity: ens210: Fix missing I2C functionality
 checks
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Salah Triki" <salah.triki@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260505172246.90892-1-salah.triki@gmail.com>
In-Reply-To: <20260505172246.90892-1-salah.triki@gmail.com>

On Tue May 5, 2026 at 12:22 PM CDT, Salah Triki wrote:
> The ENS210 driver uses SMBus transactions (such as byte, word, and block
> data reads/writes) during the probe and measurement phases. However, the
> initial functionality check only validated a subset of these capabilities=
,
> which could lead to loading failures on adapters requiring SMBus
> emulation or native-only controllers.
>
> To ensure compatibility across a wide range of I2C adapters, modify the
> functionality check to verify if the adapter supports the required native
> operations or, failing that, supports the SMBus emulation layer.
>
> Fixes: c524fbca672e ("iio: humidity: Add support for ENS210")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/humidity/ens210.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
[snip]
>  	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> -				     I2C_FUNC_SMBUS_WRITE_BYTE |
> -				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +				I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +				I2C_FUNC_SMBUS_WRITE_BYTE |
> +				I2C_FUNC_SMBUS_READ_BYTE_DATA |
> +				I2C_FUNC_SMBUS_READ_WORD_DATA |
> +				I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&
> +			!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {
>  		return dev_err_probe(&client->dev, -EOPNOTSUPP,
>  			"adapter does not support some i2c transactions\n");
>  	}

This alignment doesn't look right. Probably should be something like:

  	if (!i2c_check_functionality(client->adapter,
				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
				     I2C_FUNC_SMBUS_WRITE_BYTE |
				     I2C_FUNC_SMBUS_READ_BYTE_DATA |
				     I2C_FUNC_SMBUS_READ_WORD_DATA |
				     I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&
 			             !i2c_check_functionality(client->adapter,=20
							      I2C_FUNC_SMBUS_EMUL)) {

best regards,
max

