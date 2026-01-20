Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02543DA3E
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917994; cv=pass; b=ZcwJMlw4NlRmx7FNOOt6fA7jUn9D8TDlIH2n3aHfnbXHug7SJzPzSsy/lCqRNjzfjgQeLS5/5Qjj7rjNOEuW6yNnCa1sk7y0y8XycGLwxx2lldVwsckt1h6VGP/xEh/cCw9EImmIAGC34QSTRKZWIvUD2rV/IwC2TQkXl83qPSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917994; c=relaxed/simple;
	bh=wpxEIKPcpfz5xqKXQMz+0Waal/J17WkYT/xpNLwvFpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIu+yt7S9T+92KXw0afADPOjJupzX4AC9Pgp8h5jahiUehrE3/m2n52HDVjyoV4suWFLMtiduCyKqvAD3vNiCsafxb0ttLxG1KwHu3ZXl4YHw/3edN+F72ZVgwTIsTahv2OzMwnd3C41Jx86nlYCweTMUUl0MUqlYufOf1ou/+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGjvjIkG; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGjvjIkG"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1233b172f02so6615654c88.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 06:06:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768917992; cv=none;
        d=google.com; s=arc-20240605;
        b=RTy1JhK0Fr1YJOAQg9auJ30Xsu839tkxBuvL28xUrTKogBUCRINJe9Ba90e/qlkwRa
         rShV3l2Hwu2rMDcOY5tsj5NSFviGPO0F9wez0EO8ZjMMOGifadT55XFiwFlEnuGldE0R
         dTxj+H2VUX3yjHP9jkVhibZ3g2utiIk6rBwrWRoWKaQD8yx9Lfbgg2nevUmjKLEeqXEK
         tg43T26CFfCn+mzJHPUbLsnlkNiPHKbe0RrZfdUTmLcvdmyNUO9sPm5ZGVRv3csTg5eT
         KYqxljk35Wb5j2CjxnSESTHLGDXH/9ZRvDWxR3Xh0HpQtMJ0p3irz+KZzrUzCPh2bsSR
         0WWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VXFM7Jkpwqf/MKm70+eA7jdHdZGuqW/xQ6SJbuMNCrg=;
        fh=mSDLFB/OnXzaNQLxSxtX7MbaMe9yS8bF7IKNelxXbUM=;
        b=Z14iEhow0cjdHB1DXvkXfnptndcjByzRGX8gaCqpX5xWoCHjAJpwx7nr3XKNT7SIcc
         k52VvHUPs6uVwv2y/VBKZ679rAvA4+EXJtRGxB6Mj35Um098Y7n2T9MSAYSrpnkHZGqm
         CfJ1i3T8fcK2/l3XT5PLdB/0Lx4DDoe4TaM3wQLgC+JiAL6F664rNHLJ2kdS1FrUQJOU
         qbtbgO+2GHTRUxJlvu4lmPF4QKhOwBIeYHG0R18eIJFceC1h5/vvFYjlutlmQ8O4em4o
         codO+vErQYCRJgCAdGxReZE3X2nU8ZO0YoAuUdG3LYEbSidy8w3oDkao4UfxYW7WzLTb
         hGEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768917992; x=1769522792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXFM7Jkpwqf/MKm70+eA7jdHdZGuqW/xQ6SJbuMNCrg=;
        b=BGjvjIkG4uOb1dM73dWvbk4Hu8M58GHUOBVlOsB8DWVeY9zDC/HPtYlwHB+HJjAMrQ
         ntkNBRCVRbM6cf+NpMuQa2al3OqnbxiYUwgjJRTd5dNe0OXGMLKX9Z+IFHaH82TqS881
         c+y+3VYLH34zhmjCY6L6H/+Z6NH/AXjrs/MPXYA0rz3CCpWiMsrG+zq0Ct/giU1CxMhl
         xvRDdJV3Pog3EsjhkJir5yWiWHWFjlt5a6XGDS6XTS1zeBliuzea6ILRMlXvmNWcXSTS
         XEoJS+Es50o/314X8cJBIS+RiUKoNTE60veOxnVENWzEBx9HSzUl28TXedQXJT/Vsulx
         ZtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917992; x=1769522792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VXFM7Jkpwqf/MKm70+eA7jdHdZGuqW/xQ6SJbuMNCrg=;
        b=cQzro3g8UyjSDeK+4H9AmNVg/UnYLnr1qQ5Jpy6SHl+iCGsK79wfwM0cBQIsFt5Z4I
         wMmfpHHv9jAgVR36dJYDeZNw2RquYC6X0DfN53iC6mQ5bY4f+x32BqYWV35tAai9VIRO
         gpEHf5mAzBNp34D0zAOqXSZt9d5FW/C979o6/DjdpKXuHnSrFoH2/TGWaih6f/8EWcSV
         P0kzBMyWdO8/F5L1u7D8BKCb5XZ4wyCQOU8yLVFyINA45YmAuoXxq9xrdYxcDtRoydgB
         17LeMhBPt2gVzVpzPU7VCau78GxBWzKoRYHoKh31I0AnkbMXdDT4jNrGXWfqaAfwiK2B
         hR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNqv8Ssn7Z1MaqlU5VzXH3LX/B5iLF5JurwWQncr1pvRjfzgXc4V34xz5fd1BAA8vmCQ8zjKgsXnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGTjjtJk+CvpODazInWSmjZcSLhQbHmWgSyhfegpUi8J8AOet
	HHf+/TaxNtmeXdwlMUsj4VMtYNTEKsdUgEaLCCDUMJ/zSReePSQQwvOVgYlqpK9W3KADJ+0ywPV
	cAAi/FdqOio9pbe0kdFyj6UhaOgYGl6k=
X-Gm-Gg: AY/fxX4klW1mYmweSf1IWc/mHLWjVYblBfGJi2pXKlcT5CozdG1qo7IyGwmPWSmHJtR
	HFZzYurkVV0CPoTNBrAdgKihUAAsZSO/3jiThCPKE0t5Pq2xQ7bz5yLqSVNo7taTxKJIjwE/EQ2
	5nglVx9gpXNtMGTRZygxfDl0Qq5GXCj6gl3Gu07eCR2p9ox3UqgQuHmEvUbdzMoXGNsqDcF68Yw
	nIwzMzqoHLI+y6a7WL4pcG45mAlv08TEwlodpDUUUdiYY9Nu7/HmOth+sNWPtYna+w4EMuGI0S1
	WYSJSNtSzthdIxvasj/BAWOoUlaGTub18rqDmeLbkQ3dOnklWG4rwb0YsBwQz5NMJLPjGbsLt1b
	TD6mzQdF+NQ==
X-Received: by 2002:a05:7022:eacf:b0:11a:61df:252a with SMTP id
 a92af1059eb24-1246a95864dmr1539061c88.6.1768917991939; Tue, 20 Jan 2026
 06:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com> <20260119-tsc3400-v1-1-82a65c5417aa@protonmail.com>
In-Reply-To: <20260119-tsc3400-v1-1-82a65c5417aa@protonmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 20 Jan 2026 16:09:12 +0200
X-Gm-Features: AZwV_Qio-O-vTE5PHylE3IQy5B0233NJK43z8Dbc2ZFFAu4-CQCiqmv-S4Yu3Bk
Message-ID: <CAEnQRZAuSkDmJuMAaJwKXhZRZ868_hFbUAy+raeS-vuZPMnjxA@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: add Device Tree binding for AMS TCS3400 light sensor
To: petr.hodina@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:19=E2=80=AFPM Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
>
> From: Petr Hodina <petr.hodina@protonmail.com>
>
> Adds a new YAML binding describing the AMS TCS3400 I2C light sensor,
> including compatible string, registers, interrupts, power supply, and an
> example node.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>  .../devicetree/bindings/iio/light/ams,tcs3400.yaml | 54 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 60 insertions(+)
>

Please use the correct subject prefix. E.g: dt-bindings: iio: light

If you are not sure what prefix to use just look around:

git log --oneline Documentation/devicetree/bindings/iio/light/
