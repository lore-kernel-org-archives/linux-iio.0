Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82B331A66
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294306; cv=none; b=t6sKz7spv6D795vv88151EZuivt9Q8ZJEnZIdaKVcFEUicbUh97X75JuAekvbv3mLewlxbBEEJ5BA4IFLPnjCDbwut9YF44AcrLaeMELm80fKYWJuwtOnJvDai0BZl7+GRO6duO4K7Jn8w1Ks1DgDjxeSN39naQzeuhfWUSTV3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294306; c=relaxed/simple;
	bh=By/+eZqFEM5VaLMz1VnW74ySyDqoDe81IrXPYvQDmDo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=T/MhOykAk0if5H8K0KB8wiaymehdTGPvTPwO8hnk+kEZYINUJx8tKMuZ3A/EVz8NNGxvQFKahZnNseJKRJ6r3V+8uQEJbrfYul1CYZyo/n82DbMVpTxynHLVI0kKJAG7SqzrekzWqd7hIYkUgoZBr9aF8brFZce7iGCZNbrer0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqMoxk2z; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqMoxk2z"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-83d31ac4017so606382b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 19:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778294305; x=1778899105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PSou2Z9/z7vTfECpLev9DLhoc0ZcyF5XLNKGMWcPXPg=;
        b=OqMoxk2zaWHiD9H1VDmfzAJafc6qGF/57l4CgTiuOJw9AVmdoforkinZ+aT2La3Uzc
         YBAMR8bE78fMPrh1vnKEfAiXUZ61A1I+FIIHT4nKFZtq82VrAU3b/ybFlas+ezK1K7e3
         IVaXtjuD8YGlh1nMVrGbAGrkttriKtv2NseL233of6mxPrHJKAZtcDxE3u/OOwIgUUJk
         gjkAtBfPpgsiRl1iVlelnnSrNJG1qJobTQORL89zKlsutgRD0dou2eTmGfyqsp720IZ4
         QplDAXfX+5K/60r64QGmM/0K416cB3Ifxj2thtqY10GPQHgpm51PgbZkbh3z2xYqCdM4
         UivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778294305; x=1778899105;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSou2Z9/z7vTfECpLev9DLhoc0ZcyF5XLNKGMWcPXPg=;
        b=X8SXX9MN/fsAIMIm0rTtsxnmZ24aRMlI9ahcdyktFxpKZ6+dEtX0waE8tkpmWCClzw
         H2hHTF4JkY/58+GM+NygEWZqneMjHndsqyawhdlcRlKe32xuWhr8NpBWxo/5COQTr6FM
         j5pyNBBmyx6/2ePWNTc7jcVYtGzXNzC+8imWTMLrb1ImhFGWHnCgMTjiIFVwSHmuyvXR
         oDY/QLqBELw833QGfpf8BTcsavYIX95f4ZTV9WIgyvcfj323H3fkexSwEaNq4eORQrva
         INXuJ6TpVJzIICHtdHBEbQil1D69qHVoBs5at/Y7P28CQ415CtlWq41O3df0AcbG0+LI
         mYrw==
X-Forwarded-Encrypted: i=1; AFNElJ9wW21SgEOFlYN1ainK7T6FoiogmSV1OCk2dP6H4WGHry3PfWLe154S4BBfcrJHWFyfYoA1vDDvogQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYys2Wz3ZyLht9wJ1RFxk0SlbBrSL38dtUKcX4IZURQILJKG9
	YWrXFZMHidokFsikQcyDLP10vwcEFdZJ5S51emYhuswX63GDvJ+acfVh
X-Gm-Gg: Acq92OED/S5Nva2pcOrjywJaT61BnciBYut0Qt4PzlTodnOgz33MN26W83qB+C4W682
	BgXRpBLpDODKBMFfuAtiZ3Ow1R9mD0u1/Mw39QT+qQdZtSFEgiDZnn8c7JTJLigBfqP0V7rzB6k
	mAU992S4ktTt27QeaEDMRXZ76XNFPAniLVIr+7bs3tgEtSNBGiaysH10PmzAt9DAbpp6NaFfYmQ
	D4IopThCzYFCno9TNDIfIyg+1HaZ7FqCQPBijgATjNNjZw0DR1AvLC7gEIsWacZRAwDfFljDLQZ
	SqTYW1wS1cD8rx3UdOf7gGb1KVSeh8aKo6BanaG0zb1wpVEinQD1S1PA96L0Um3Gon9fueOwzFE
	Nd3lBdSjwwwcbiHEiL6t6QaU/rH33Yp1yzC3UYRtbH2A+Ca1wQWgNJcRfzudnRgVmL1Sk1RFTBr
	7jty+BMsCQruVZuZrbyptUaAAJpJTAl+eOQVE52jQgRfSKdPWkXj7EC5cePQ==
X-Received: by 2002:a05:6a00:2793:b0:835:3f51:72fb with SMTP id d2e1a72fcca58-83a5b8d20dfmr14023721b3a.12.1778294304450;
        Fri, 08 May 2026 19:38:24 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:791b:cfa1:9b60:879e:786b:b8d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a272asm13914537b3a.54.2026.05.08.19.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 19:38:24 -0700 (PDT)
Date: Sat, 09 May 2026 07:50:40 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: dds: Add AD9832/AD9835 binding
User-Agent: Thunderbird for Android
In-Reply-To: <20260509013745.80478-2-dennylin0707@gmail.com>
References: <20260509013745.80478-1-dennylin0707@gmail.com> <20260509013745.80478-2-dennylin0707@gmail.com>
Message-ID: <1B57A7B8-6ED1-4F90-9AC0-924635520E64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 9 May 2026 7:07:45=E2=80=AFam IST, Hungyu Lin <dennylin0707@gmail=2Ecom=
> wrote:
>Add devicetree binding documentation for AD9832 and AD9835 DDS devices=2E
>

Hi,

It looks like you have sent multiple patch versions within 24 hours=2E

I would suggest taking some additional time for development and validation=
 before sending updates to the mailing list=2E It is also good to allow rev=
iewers enough time to provide feedback, atleast a minimum of 24 hours=2E

Please be patient and wait for a few days, or ideally upto week, so review=
ers have sufficient time to review the changes properly=2E

Thanks, Sanjay=20

>These devices are SPI-controlled direct digital synthesizers
>requiring AVDD, DVDD supplies and an external master clock=2E
>
>Require spi-cpol since AD9832/AD9835 use SPI mode 2=2E
>Update the example to include spi-cpol and use a generic node name=2E
>
>Signed-off-by: Hungyu Lin <dennylin0707@gmail=2Ecom>
>---
> =2E=2E=2E/bindings/iio/dds/adi,ad9832=2Eyaml          | 91 +++++++++++++=
++++++
> 1 file changed, 91 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832=
=2Eyaml
>
>diff --git a/Documentation/devicetree/bindings/iio/dds/adi,ad9832=2Eyaml =
b/Documentation/devicetree/bindings/iio/dds/adi,ad9832=2Eyaml
>new file mode 100644
>index 000000000000=2E=2E9f3e41cb0a0d
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/iio/dds/adi,ad9832=2Eyaml
>@@ -0,0 +1,91 @@
>+# SPDX-License-Identifier: (GPL-2=2E0-only OR BSD-2-Clause)
>+%YAML 1=2E2
>+---
>+$id: http://devicetree=2Eorg/schemas/iio/dds/adi,ad9832=2Eyaml#
>+$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml#
>+
>+title: Analog Devices AD9832 / AD9835 DDS
>+
>+maintainers:
>+  - Hungyu Lin <dennylin0707@gmail=2Ecom>
>+
>+description: |
>+  Binding for Analog Devices AD9832 and AD9835 SPI-controlled direct
>+  digital synthesizers (DDS)=2E The devices use an external master clock
>+  and are controlled over a serial SPI-compatible interface=2E
>+
>+properties:
>+  compatible:
>+    enum:
>+      - adi,ad9832
>+      - adi,ad9835
>+
>+  reg:
>+    maxItems: 1
>+
>+  spi-max-frequency:
>+    maximum: 20000000
>+
>+  spi-cpol: true
>+
>+  clocks:
>+    maxItems: 1
>+    description:
>+      External master clock input=2E
>+
>+  clock-names:
>+    const: mclk
>+
>+  avdd-supply:
>+    description:
>+      Analog power supply=2E
>+
>+  dvdd-supply:
>+    description:
>+      Digital power supply=2E
>+
>+required:
>+  - compatible
>+  - reg
>+  - clocks
>+  - clock-names
>+  - avdd-supply
>+  - dvdd-supply
>+  - spi-cpol
>+
>+allOf:
>+  - $ref: /schemas/spi/spi-peripheral-props=2Eyaml#
>+
>+unevaluatedProperties: false
>+
>+examples:
>+  - |
>+    mclk: clock {
>+      compatible =3D "fixed-clock";
>+      #clock-cells =3D <0>;
>+      clock-frequency =3D <25000000>;
>+    };
>+
>+    vdd_3v3: regulator {
>+      compatible =3D "regulator-fixed";
>+      regulator-name =3D "vdd_3v3";
>+      regulator-min-microvolt =3D <3300000>;
>+      regulator-max-microvolt =3D <3300000>;
>+      regulator-always-on;
>+    };
>+
>+    spi {
>+      #address-cells =3D <1>;
>+      #size-cells =3D <0>;
>+
>+      dds@0 {
>+        compatible =3D "adi,ad9832";
>+        reg =3D <0>;
>+        spi-max-frequency =3D <20000000>;
>+        spi-cpol;
>+        clocks =3D <&mclk>;
>+        clock-names =3D "mclk";
>+        avdd-supply =3D <&vdd_3v3>;
>+        dvdd-supply =3D <&vdd_3v3>;
>+      };
>+    };
