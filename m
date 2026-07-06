Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710183C3C0C
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371048; cv=none; b=aDnlFK8A3nPeNN3Cj2vjbz5NKg1Uam7ItDE68AfCTnUjp57b3dIIXM9eYREY9XDElSKu5Y7bzp8nkYGzLWXU0BuDcrwWp9Hj/nHPn6IBrmlWv6JDbnOz5+eGbH8Y3vs2H/eAgmsL3Rj2H3X+urp2eAe+TM5cMqbMJS4H8xSqp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371048; c=relaxed/simple;
	bh=JmDGsFaY4py38Lh7Xj2V/bfF3K78aZHKimIXo5XmpSA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:From:To:Cc:
	 In-Reply-To:References; b=h+6WW5YBEDHFgpuuMoJzwcTx/ouWZtmbHnyOUxGYm7JuhzlJEmAFyxJBQQPc+R8L7Sy3uEgI0Y8S77vpWGO4ljb5LJhnLmgRRLOMRbMa7oKTevBBpx9vmBPS8LJfO617VclxSMxSfwM/FVRbYZsJSc3v7Oq+ioHZ1jEsAqKxAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dir4Uu2y; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dir4Uu2y"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39b315585a4so23788731fa.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783371045; x=1783975845; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:from:subject:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmDGsFaY4py38Lh7Xj2V/bfF3K78aZHKimIXo5XmpSA=;
        b=dir4Uu2yn7r+Rlpp+uiTeuiXRDUNIeQsZLCDM/fr1xe1wUYeF21porSCoFLMqGEn+V
         Y+nZLGrg2wSifKay8n4+/3NHTfEQU0Z3+gzquKNhJkUOK8mzWeNWA2YB+nzKX3Rj/tnB
         BaKPSGlkGkBFi5A1cdvNQn9TLJ+FHaNFsce0X5j6YoCmnqgjZaSx/uBpyOMJy/5zSyS5
         LA58Grd6Q7iopIm2v0Jqq0WwlOYqHcSIttD+F+dd8cv5bHlXT+ysQti79pXWCowNmdG7
         44b7S7oRwagGYQWGbGRZh4TMnC0u+4BwajazmB1BbyRrMURQnMdMWaslO9P8ZB7TPTO7
         HAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371045; x=1783975845;
        h=references:in-reply-to:cc:to:from:subject:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmDGsFaY4py38Lh7Xj2V/bfF3K78aZHKimIXo5XmpSA=;
        b=djO5mm9C3H/vPrVmrbR/PrLSiJIj5HuruUoYlL2pFa2nxed8wavBWKRLfXh4FXaJV4
         Twax0shqahNx6GQRaidWLDr6x5pw+pG8ZNJ0wrbktYU3xgn0gPT3QO0bKhdI775uE7Bz
         EDjButIcPgS3MjMmWKXYTtUb85q9E6qmHzLOU8dpWaocgs/eL2KiG9vQ33i/pvb9xPxL
         lF73CkR7SbboAqfKUptxQlijHcG/EVosE6GRVrJjlmmmLtiLcTJ5vndTs64aKoP8Cu0V
         LnsNqLldEUZnhs4XSS5JKxxe3q/WXgXpJrgHVp4xCxM384sxu9xV3Rxu98Aoocz0T4A+
         gQDA==
X-Gm-Message-State: AOJu0Yx5+TRUS+qILxs2topSNwKMoFHbP4EOiQRK+euvKFPghgyv4zHa
	YZvWXdzB/A6ibQ+dEC/0yDkdcZSxZ9ZRvNnfmHDQbI+EVq3SaAZkQF0oqEg0X06JXaE=
X-Gm-Gg: AfdE7clob2TMhmmOp8/8my9DxUkNsiamKh4Yyj9ROBrcmQ6nI0fkYbJt2q67Re39gxF
	FPqjpL5cUcT8/zm173HzMsjn8PHJTmbOOWkntXK7EcZWsdGp861u+DM7DN3e3/Np+BLSsiPe9XR
	QABmjqkzEqBBaS+oILqJBXA4l5gT0B/Hj/NgX2L+Oec/Z3RnI15qgMLY//QM1LAovsWwvSUHht1
	mofJ1XvIqbjcxNiMqxsICqidDxMhGQtBnTtnnQQiNHE/EYzJSxOdWt9CQozMSPnJr7Uo4xTo4ki
	UYbaLlo2uEnG1MyLgMnecC/N5VgGplpCZjfuqnQdr9AebvXxvHfLz7Kkt7WdsEnCoLVDEWGFZ3t
	GRkW+6EZULg3YLgpkZbfTJeyI1nPll7I2A95swQvB95ACxvwhclBLkYPpXSkCv+S5M4qkl9j3I+
	GeFArRqwwqjlDjNXcyVybb9tjWdkPTz9zTBL6JaeugH4+6SqHSU2zPteI=
X-Received: by 2002:a05:651c:4005:b0:39b:ddb:8f17 with SMTP id 38308e7fff4ca-39c60035977mr4271151fa.33.1783371044363;
        Mon, 06 Jul 2026 13:50:44 -0700 (PDT)
Received: from Shofiq.localdomain (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c61a1d72esm2722051fa.16.2026.07.06.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 13:50:42 -0700 (PDT)
Message-ID: <6a4c1522.63d4a161.13ea90.1761@mx.google.com>
Date: Mon, 06 Jul 2026 13:50:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: Re: [PATCH v5 2/3] iio: health: add MAX86150 ECG and PPG biosensor driver
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org, krzk@kernel.org
In-Reply-To: <20260702044246.68e4dfd7@jic23-huawei>
References: <20260702044246.68e4dfd7@jic23-huawei>

T24gV2VkLCAyIEp1bCAyMDI2LCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOgo+IFtQQVRDSCB2NSAy
LzNdIGlpbzogaGVhbHRoOiBhZGQgTUFYODYxNTAgRUNHIGFuZCBQUEcgYmlvc2Vuc29yIGRyaXZl
cgoKVGhhbmsgeW91IGZvciB0aGUgdGhvcm91Z2ggcmV2aWV3LiBJIGFwb2xvZ2lzZSBmb3Igc2Vu
ZGluZyB2NiBiZWZvcmUKYWRkcmVzc2luZyB0aGUgZHJpdmVyIGZlZWRiYWNrIOKAlCB0aGF0IHdh
cyBhIG1pc3Rha2UuIHY3IChiZWluZyBzZW50IG5vdykKYWRkcmVzc2VzIGFsbCBwb2ludHMgcmFp
c2VkIGJlbG93OgoKQXJjaGl0ZWN0dXJhbCBjaGFuZ2U6Ci0gU3dpdGNoIGZyb20gZGV2bV9paW9f
dHJpZ2dlcmVkX2J1ZmZlcl9zZXR1cCgpIHRvCiAgZGV2bV9paW9fa2ZpZm9fYnVmZmVyX3NldHVw
KCkgd2l0aCBpaW9fYnVmZmVyX3NldHVwX29wcwogIChwb3N0ZW5hYmxlL3ByZWRpc2FibGUpLCBt
YXRjaGluZyBNQVgzMDEwMCBhbmQgTUFYMzAxMDIuIFRoZSBJSU8KICB0cmlnZ2VyIG9iamVjdCBh
bmQgdHJpZ2dlcl9vcHMgYXJlIHJlbW92ZWQgZW50aXJlbHkuCgpLY29uZmlnOgotIFJlbW92ZSBz
cHVyaW91cyAnc2VsZWN0IElJT19UUklHR0VSJyBmcm9tIEFGRTQ0MDMsIEFGRTQ0MDQsIE1BWDMw
MTAwLAogIE1BWDMwMTAyLiBUaG9zZSB3ZXJlIHdyb25nIOKAlCBJIHdhcyBub3QgdG91Y2hpbmcg
dGhvc2UgZHJpdmVycy4KLSBNQVg4NjE1MCBub3cgc2VsZWN0cyBJSU9fS0ZJRk9fQlVGLCBub3Qg
SUlPX1RSSUdHRVIgb3IKICBJSU9fVFJJR0dFUkVEX0JVRkZFUi4KClJlZ2lzdGVyIGZpZWxkIG1h
Y3JvczoKLSBBbGwgcmVuYW1lZCB0byBpbmNsdWRlIHRoZSBwYXJlbnQgcmVnaXN0ZXIgbmFtZSBh
bmQgX01BU0sgc3VmZml4LAogIGUuZy4gTUFYODYxNTBfUFBHX0FEQ19SR0UgLT4gTUFYODYxNTBf
UFBHX0NPTkZJRzFfQURDX1JHRV9NQVNLLgoKQnVmZmVyIGRlY2xhcmF0aW9uOgotIHMzMiBidWZb
Nl0gLT4gSUlPX0RFQ0xBUkVfQlVGRkVSX1dJVEhfVFMoczMyLCBidWYsIDMpLgotIEFSQ0hfRE1B
X01JTkFMSUdOIC0+IElJT19ETUFfTUlOQUxJR047IGNvbW1lbnQgYWJvdXQKICBDT05GSUdfRE1B
X0FQSV9ERUJVRyByZW1vdmVkLgoKRklGTyByZWFkOgotIGdldF91bmFsaWduZWRfYmUyNCgpIHdp
dGggYSBzaW5nbGUgbWFzayBmb3IgZWFjaCAyNC1iaXQgd29yZCwKICBtYXRjaGluZyBzaTExMzMu
YyBhbmQgcm0zMTAwLWNvcmUuYy4KCkVycm9yIGhhbmRsaW5nOgotIGlmICghcmV0KSBjaGFpbnMg
cmVwbGFjZWQgd2l0aCBnb3RvIHRocm91Z2hvdXQgcmVhZF9yYXcgYW5kCiAgYnVmZmVyX3Bvc3Rl
bmFibGUuCgpyZWdtYXAgaGVscGVyczoKLSByZWdtYXBfdXBkYXRlX2JpdHMoLi4uLCBTSEROLCAw
KSAtPiByZWdtYXBfY2xlYXJfYml0cygpLgotIHJlZ21hcF91cGRhdGVfYml0cyguLi4sIFNIRE4s
IFNIRE4pIC0+IHJlZ21hcF9zZXRfYml0cygpLgoKSVJRIGhhbmRsZXI6Ci0gT3ZlcmZsb3c6IGZs
dXNoIEZJRk8gcG9pbnRlcnMgYW5kIHJldHVybiDigJQgbm8gYXR0ZW1wdCB0byByZWNvbnN0cnVj
dAogIHRpbWVzdGFtcHMgZnJvbSB1bnJlbGlhYmxlIGRhdGEuCi0gbWVtc2V0IG9mIHB1c2ggYnVm
ZmVyIHJlbW92ZWQuCi0gaWlvX3B1c2hfdG9fYnVmZmVyc193aXRoX3RpbWVzdGFtcCgpIC0+IGlp
b19wdXNoX3RvX2J1ZmZlcnNfd2l0aF90cygpLgotIHBmLT50aW1lc3RhbXAgcmVwbGFjZWQgd2l0
aCBrdGltZV9nZXRfbnMoKSAobm8gdHJpZ2dlciBvYmplY3Qgbm93KS4KCk90aGVyIHN0eWxlIGZp
eGVzOgotIEFsbCBjb2RlLXNlY3Rpb24gY29tbWVudHMgcmVtb3ZlZCAoLyogVHJpZ2dlciAqLywg
LyogUHJvYmUgKi8sIGV0Yy4pLgotIEZvcmNlZCB2YXJpYWJsZSBkZWNsYXJhdGlvbiBhbGlnbm1l
bnQgcmVtb3ZlZC4KLSB1c2xlZXBfcmFuZ2UoMTAwMCwgMjAwMCkgLT4gZnNsZWVwKDEwMDApLgot
IDEwMDAwMDAwIC0+IDEwICogTlNFQ19QRVJfTVNFQy4KLSBMRURfUEFfREVGQVVMVCAtPiBMRURf
UEFfNTBNQS4KLSBQYXJ0IElEIG1pc21hdGNoOiBkZXZfd2FybigpIGluc3RlYWQgb2YgcmV0dXJu
aW5nIC1FTk9ERVYuCi0gSVJRIHRyaWdnZXIgdHlwZSBmYWxsYmFjayAoSVJRRl9UUklHR0VSX0ZB
TExJTkcpIHJlbW92ZWQuCgpSZWd1bGF0b3JzOgotIHZyZWYgcmVtb3ZlZCBmcm9tIGRyaXZlciBh
bmQgRFQgYmluZGluZyAobm90IGEgc3VwcGx5IHBlciBkYXRhc2hlZXQpLgotIGRldm1fcmVndWxh
dG9yX2dldF9lbmFibGVfb3B0aW9uYWwoKSAtPiBkZXZtX3JlZ3VsYXRvcl9nZXRfZW5hYmxlKCku
CgpTaWduZWQtb2ZmLWJ5OiBNZCBTaG9maXF1bCBJc2xhbSA8c2hvZmlxdGVzdEBnbWFpbC5jb20+
Cg==
