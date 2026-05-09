Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C729BDAA
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292269; cv=none; b=YchIHvIDcPth77J1dQD5saSW64WiWgv2QNJRlNRqPBbsGhqral4bSxBu5wu7dMJnjtp9OXsRo+Z80iGw1yjTa72CwsStkrDmrW6cCRIKWA8//X3YxjA+Kn/Pg6gDUglPCcWv7M1uo0mcNyiTPLCydnyKbW2T007+tgWeHldIqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292269; c=relaxed/simple;
	bh=67cQx5h5EfVqCG/fdK6oUL+AYJQaEpxH3q2e02Z+Ytw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pWyJm0m0BvrdhApmhnHygqn2sCmTa2Voe0k9dTS7zlN6vyDOj1HAa4t+IKDsloPQvMMht587kQ/kJozHThJr/hq6hCdB0joFbo3r+GX/i9c6IpL64SPwgbfN4FetQoLR6cUQ9N5deHZO/AN8GXZGHvmJ0H1TVzcijm6DSJxOgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW/+A+SF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW/+A+SF"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-837cd669be0so2030423b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 19:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778292266; x=1778897066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=90WqjeRA8ThNFX5d+11lotpk8MoHTD4XnnqbeBD8jm0=;
        b=XW/+A+SF2yz4v20/VK++5SBeu1GirwM6QB/R5K81x+NzC/YewyFFueMcWrl3N10OGl
         WP1kpx/HcMHo357+fTqHiUpxHA0qmmLrRBmCqKtcIVYmTJaT0/8tOfaV0LBO6CwU+eiU
         aP3jKRiWTv4xcfzV7xhuuPi52ujyLW9kM/5GBtu331qYbuycWwv7BpiZQGFBDOwC+77D
         uRvV6lzJB9R1xQSSbDHrIYKY/IPMgcJfNMZC0k/QACLAQoD7PgirRtupwE7tziTUuFBg
         iVOnwPYoJpX+SG5AbcXsXGEe8E+86iX6oKihdk0pMGK4sJvnqLbypOq2/VxlPna3w0Vc
         e6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778292266; x=1778897066;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90WqjeRA8ThNFX5d+11lotpk8MoHTD4XnnqbeBD8jm0=;
        b=Rz8Et0y3bHMmrQqGNA7QyiVh1QVNJg0cIOBZVRgcVSpqAv8VRiWIv/onkgTO9yYb/m
         e+HVEPLTsd6JbFE5mkaKipK9+ZP+MDocVYuIvjlSLpeq16rB+ODXv3s5Xvvcpj+5eyeQ
         YoBLhON7wqispQhuT97oLRVVADIuy4PiK+NnHf0ecG33Kxo5ZJlzE2zcDtYiDPSl6dlF
         XNHD2kACq6rZUNcfU3f35/DHXYEgt1iDlbNn5Tt5db0mSwfLmu+/7GzWzZqtHqVRv3wv
         NQ6n0DU0XxR8z9xOCzhTwKQ3RHgqv/jcGT6/CXrtERNJtVGw24jDeiVg+q8S9UvSfZRV
         8X3A==
X-Forwarded-Encrypted: i=1; AFNElJ/H4T7JV/qfEjnrhtOFsNCRYMtSpxCY2J1hvN2wxhcqp+TJRYz8ehhxrk/QIRtgtU4lpsNeDqv2ERA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBOPS+FWrtgqxJbwhK9+g91w9SpZBnZJz98QlUCdpxH2GII4O
	TpQg+Wz9xP3kvG6B2bVJqgyrviQXRmH3jTpS1DFWBMvvsc7ACft69nh7
X-Gm-Gg: AeBDievwB1Igfpwsbz3BM199DzQGwJ/Sy4jQo2Hg+kk48OPeMryahL9njBqX1DbyXeo
	aAIgZcaoB7mO9XM/GiN9tX4z284U88+3Qrm2dQSciLA2cQTaihd+sy4kRGdrxalhyQbmrnzDSWp
	2dBFinMd6pSkoFRI82Kmszq8u+BvlhBUfTswFDlc088ZcLwFfK53mg9ad0UmEHnxZ4Fv3RufmOe
	SqYfSLjwTS7d9t70VbR6laPaZ3wwhtpdge3ov4P+WRyJlC1SeBayUQ3vx1nRXMypyMXD/wWTSuj
	8zwdwD79DxMXDrkrG137hez7ezMN2lmNRc8zo92tTzoKtz7TiqpTFur7bKX0kLVtWJ+A9ObTXlt
	t8q0uu1lS1jlQkcR1fF5fAephjTn5lrWS1ErhmxpmeCvzzE2Bh/FT3AI9Bs7iXKfcwH/ZVqsaLd
	TBtqJU1qG+vsEqEf/cP28Bu3jCezncimR3PeXhHi+4/UXifbg=
X-Received: by 2002:a05:6a00:8014:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-83a5b6d0a28mr15321522b3a.10.1778292266253;
        Fri, 08 May 2026 19:04:26 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:791b:cfa1:9b60:879e:786b:b8d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839683a088fsm13566241b3a.58.2026.05.08.19.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 19:04:25 -0700 (PDT)
Date: Sat, 09 May 2026 07:34:17 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
CC: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/1=5D_dt-bindings=3A_iio=3A_?=
 =?US-ASCII?Q?adc=3A_add_AD7816/AD7817/AD7818_binding?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260508231147.77044-1-dennylin0707@gmail.com>
References: <20260508231147.77044-1-dennylin0707@gmail.com>
Message-ID: <0D2B5076-A5D7-4D14-B58B-E500585DD465@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 9 May 2026 4:41:46=E2=80=AFam IST, Hungyu Lin <dennylin0707@gmail=2Ecom=
> wrote:
>v2:
>- Fix commit message to match binding requirements
>
Hi,

Thank you for the change=2E

Ideally, multiple logical changes should be split into series=2E For a sin=
gle patch you can include changelog like this:

Signed-off-by: =2E=2E=2E=2E
---
Changes in v2:
- Fix commit message to match binding requirements
---
 =2E=2E=2E/bindings=2E=2E
         | 94 +++++++++++++++++++

If reviewer specifically asked to update commit message, you can mention i=
n the changelog as well=2E for examle:

- Fix commit message based on input from <Reviewer Name>

Replace <Reviewer Name> with the actual reviewer=2E

>Hungyu Lin (1):
>  dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding
>
> =2E=2E=2E/bindings/iio/adc/adi,ad7816=2Eyaml          | 94 +++++++++++++=
++++++
> 1 file changed, 94 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816=
=2Eyaml
>
