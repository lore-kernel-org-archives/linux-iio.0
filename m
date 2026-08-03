Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286638A71E;
	Mon,  3 Aug 2026 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778126; cv=none; b=DAJGD3DifZTO7iLyNdiSMvpkKjqV0SyRFrhJwyMei2W8E3vbQ4MriVvBwHW3toXUZ5tSyWWam9t2tpFhsUBcIkD0+ROsvtWf6NYIzY6qI0sw7bOndDH2g3EXblggKHdBvINxtXvO2Dc0R1WK2LSXnCJmXt7wIZo9GXqHUkVIfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778126; c=relaxed/simple;
	bh=GT+yfWLFAPExdbDJ5COk1PTpR3MMG3NsRmwyhEWOYjM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Fh7XpEGhNapgd895h9/F9jJ9kfHM4vOZs8DWKMF6dMUoHxw/eeMDImGP/pDZxApEFQxjMRvcN9PbmSNYMgFvQ9ved/AA6Lg0wPa9jxByh+13rZgw8/U16yNk9839Wp4PoDpakpKbUe7lBIl760SxPvWfJjwn4O611q/2hsBwP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gdDyn7aU; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gdDyn7aU"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9C99B887E9;
	Mon, 03 Aug 2026 19:28:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zej7F0WdACzl; Mon,  3 Aug 2026 19:28:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785778115; bh=GT+yfWLFAPExdbDJ5COk1PTpR3MMG3NsRmwyhEWOYjM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=gdDyn7aUsb6UsGC1GJ4OsW/ceiz5FmLDYl2c/KmfW8Xbe4PCxxHdkgMvjUbH3YyFA
	 hUgm0T9hqnYCAv72T6bvA50SjREcrWPqpx0KNi5YA820ywxUnsN3w3Ud3G+wDeIBxt
	 9jY/kxH4M9rvh9e7F/s8yys83uiKzBfMpacBr4KVe2QSujvzBmkBXcVY3xlbzW1nwX
	 6jz9F0Ypy8S90x7publ6Ybu/7e9KsKw9VjpS3DnPSgg12UkjsdSOdCPLF1XMjBJksd
	 BGtBWAQ1B5Esv13XCjIN0jMS9066jAHGFNP72QakW45VanwWLmqDTHw82Y4dvQjDUF
	 knZnmHY2I4Sug==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 22:58:24 +0530
Message-Id: <DKFHI80E1741.3L5TMU6D3P9OC@disroot.org>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: proximity: add driver for Sharp GP2AP070S
 proximity sensor
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "David Lechner" <dlechner@baylibre.com>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>, "Jonathan Cameron" <jic23@kernel.org>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Peter Griffin"
 <peter.griffin@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>
References: <20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org>
 <20260731-gp2ap070s-v3-2-d1f5cecf9fe7@disroot.org>
 <380b864f-6266-40fb-87a4-027afb422885@baylibre.com>
In-Reply-To: <380b864f-6266-40fb-87a4-027afb422885@baylibre.com>

On 2026-08-01 11:41 -05:00, David Lechner wrote:
> On 7/30/26 3:07 PM, Kaustabh Chakraborty wrote:
>> The GP2AP070S is a proximity sensor designed and manufactured by Sharp
>> Corporation. This sensor is used in mobile devices, including, but not
>> limited to - the Samsung Galaxy J6.
>>=20
>> The driver has been adopted from Samsung's downstream kernel
>> implementation [1]. Due to the lack of public documentation about the
>> schematics of this device. The downstream driver acts as the secondary
>> source of information. Driver clarity has also been improved with the
>> help of the GP2AP* drivers in iio/light.
>>=20
>> Link: https://github.com/Exynos7870/android_kernel_samsung_universal7870=
/blob/lineage-16.0/drivers/sensors/gp2ap070s.c [1]
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---

[...]

>> +static void gp2ap070s_reset_action(void *private)
>> +{
>> +	struct gp2ap070s_drvdata *drvdata =3D private;
>
> Usually, we don't bother with a cast/local variable in these.
> The void* can be passed directly as an arg.

Yeah, but CFI will not be happy about that.
