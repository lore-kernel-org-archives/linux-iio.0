Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4130EF63;
	Tue, 20 Jan 2026 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917074; cv=none; b=D12I1HXnyPEzOr0Bm9T4kFfSg43UBgH4jPmdD0+PWivYNH8mZtucGyWOZ0ghikcqThw+7FOTiJS7UeDACe7q1sor+i+4EAeJD2bKkJtyIKl5u4ymrVdbqpNBhwbu860IA5gJejKpdNPc6OQpA6zSKHjbyyCr12OnAQJvxCmoKns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917074; c=relaxed/simple;
	bh=GlsBR4c+63bafGGmpnlsMkWHz03KHLKQuk0j0NtOaGk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOqzJBJspjuHNOgL7LaVYuJA/jO2eLHdomxW1BBoucXOJaaiF6Q33PIbNmkagAzCWShKr8RgjtDxKCS0SlP9kTwF+ctIHOp9wTNGOA7yRxXdKqWYTRRrqb7RSvmpM6b1jlQSj0FcOScAyZExf2cFhAMVwIxuc1U+U9fjYvSphno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qcE20BdS; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qcE20BdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1768917069; x=1769176269;
	bh=GlsBR4c+63bafGGmpnlsMkWHz03KHLKQuk0j0NtOaGk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qcE20BdSu9+O+/8zkq0dP2w1kkWz14VZCZ6HPvoMJhO9eRS4ti0HaiMigVIqdk+2R
	 3GP8WcT8awmBea6xkp68xMPAiMRWzRN5/yXlEHfroJ9dTTLDFab62e/VeffeIf5Uq0
	 7rGoKpaPso5leqrj5MWpqvt7DLFeZ47CjOq5oy9J3clrFQlOCn6XbLxYp3NBYA5+Ww
	 m61wsEDiz5Wpxq6YzwZtIAO07aHXQQkAACaHMNsFF97YFgDHjbKmhS1ebwTW8nNOZN
	 /Xp96YkZ/xYZMlVKPzdcPpWSmYF7t4kXx5f7/4qPTaYcefo6r9tgGJwaFZQj2RLsxZ
	 ibM2lrLoqiIfA==
Date: Tue, 20 Jan 2026 13:51:03 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: phodina <petr.hodina@protonmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: light: add AMS TCS3400 RGB and RGB-IR color sensor driver
Message-ID: <iRHbGC3J-Do8RXQIaOqoVYAtebUbQGrJ_H63p4NBgKPUeTBw9dDHGK0YXwd-BhARpOTr_t-C1-rzj-W08AqfiUaLhzXd-4T62V3c82ASQDY=@protonmail.com>
In-Reply-To: <aW-EFdqRQRFDJ-EO@smile.fi.intel.com>
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com> <20260119-tsc3400-v1-2-82a65c5417aa@protonmail.com> <6ad1855a-acf9-43e9-a8ab-303f553eae77@oss.qualcomm.com> <aW-EFdqRQRFDJ-EO@smile.fi.intel.com>
Feedback-ID: 23468634:user:proton
X-Pm-Message-ID: e949b899b5cd61cc9350ba8f01e6fcad28f49193
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Konrad for posting the datasheet.

I used directly the link from the vendor site.

https://look.ams-osram.com/m/595d46c644740603/original/TCS3400-Color-Light-=
to-Digital-Converter.pdf

Will add the link to the driver commit.

Kind regards
Petr Hodina


On Tuesday, January 20th, 2026 at 2:33 PM, Andy Shevchenko <andriy.shevchen=
ko@intel.com> wrote:

> On Tue, Jan 20, 2026 at 12:03:26PM +0100, Konrad Dybcio wrote:
>=20
> > On 1/19/26 6:19 PM, Petr Hodina via B4 Relay wrote:
>=20
> > > Add support for the AMS TCS3400 I2C color light-to-digital converter.
> > > The driver supports RGBC and RGB-IR modes, programmable integration
> > > time, optional interrupt-driven buffered capture, and regulator-based
> > > power control.
> > >=20
> > > Signed-off-by: Petr Hodina petr.hodina@protonmail.com
> > > ---
> >=20
> > FYI this is the driver that shipped on Sony phones:
> >=20
> > https://github.com/LineageOS/android_kernel_sony_sdm845/blob/lineage-23=
.0/drivers/misc/tcs3490.c
> >=20
> > And it seems there's a datasheet available:
> >=20
> > https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/897/TCS349=
0.pdf
>=20
>=20
> Thanks for finding this! It can be transformed to Datasheet tag
> in the commit message.
>=20
> --
> With Best Regards,
> Andy Shevchenko
