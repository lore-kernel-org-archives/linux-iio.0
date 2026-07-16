Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41440343D80;
	Thu, 16 Jul 2026 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196704; cv=none; b=DNOGzlQDFcrjL8Hem6ywmQXcJtDAnpYdEmeL8uoz4HSgwx8Uj07IdJZjqTMBbBfC1GEX27azJT2nHiSqflT1TWESz5HGqGAxMkeuY8FP5n4mPlm9qmptXji/QhSec/eA9MTt5CW/zXO7pOD1WE9f1Bd/DwomlFF9tJhPyJbfoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196704; c=relaxed/simple;
	bh=HppNYGvxBStNecsyGrgq/kpasiNMn52yE9/QvS51cr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l273YXXXFw5m0x90RHMlO6VvkfVjmymvKXm5Mz7ata5QZONNLYTaRbQmEQNvPAMDdRaW+o9tOoU5/HNLWrul7ijI9iJVJvkIihcpGwTsjfhIs6Zh6OjgiUql1LCxjvZ3DiyqyqAptdd0PBhBe2+kT4wUp+fkuOGTG3Dlr8bpztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZwAPA873; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZwAPA873"
Message-ID: <0f362ce990c098012f6c9c6d4de817356aa71f94.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784196700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HppNYGvxBStNecsyGrgq/kpasiNMn52yE9/QvS51cr0=;
	b=ZwAPA873wcJQxZRkeO/sPnB3OGivDRK/ge6/qoUXlMiUg2lSFJvAJ7bkiWyiJ/y1FZAUEF
	yA+a2HHPud4edawzE9mpqxwfMI0fkpFhf0JmJ4nW00DX9eobqY4AVvWJ44fKkUUek5Cle1
	Tdgv/0nc1uXNZ0jYe3es/1CGGSOGKlg=
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 16 Jul 2026 16:11:16 +0600
In-Reply-To: <d7fffbeacc77c3135564f902c41f19a219ddce75.camel@linux.dev>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
			 <20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
	 <d7fffbeacc77c3135564f902c41f19a219ddce75.camel@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Thu, 2026-07-16 at 15:52 +0600, Siratul Islam wrote:
> On Tue, 2026-07-14 at 22:28 +0200, Jorijn van der Graaf wrote:
> > ...
> >=20
> Hi! the driver looks clean overall. I see you have followed ;
This text got cut off somehow.
...
> >=20
> > +
> > +MODULE_DESCRIPTION("QST QMC6308 3-Axis Magnetic Sensor driver");
> > +MODULE_AUTHOR("Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>");
> > +MODULE_LICENSE("Dual BSD/GPL");
> --
> Best regards,
> Sirat
Looks like Evolution has messed up the formatting somehow. Sorry for that.

--
Best regards,
Sirat
