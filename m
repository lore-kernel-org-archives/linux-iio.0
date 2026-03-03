Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B130DEDD;
	Tue,  3 Mar 2026 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527445; cv=none; b=fmKTZsBJOpYOhHwPn7PJjUXtTtkU4o87bSf7QY3cLRws+5m9DpeXaNXtrk6JIFnEH8mMvAg6BqPJC0EwEJ3mdW8cCcZSWtrwAKZGmBpWbzd8fk/KhTnccK7vOQSdZ28FN0P5mhJXbSBEDFm/koGUnX8BeuOQ+ZVm5sOJg1HjbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527445; c=relaxed/simple;
	bh=Sk2DLe7j41mdP/Fd2xkluRJL23RLlfnisU6PUZoQytE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jIVsoDmki2xQqwQD3OxoeSgMFZdKoslUFwXZRqR8JI8kUslkDC/gRowG43TVF/ciphH+hShqw5m22ZRDYP+tl8+0VceaWgcTxdxFUDp1YATatinM6ziiyedKvTWbq9MtgRlNWv1ztuPagtuv0QKbI54aon7DCcFBWMacI1G1hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BO2xH61W; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BO2xH61W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772527415; x=1773132215; i=markus.elfring@web.de;
	bh=CNAsx4LhxE8wJFPl0WVjg/q4JOxSUBbmyh2ShyPJFP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BO2xH61WdeEpYNHIQS1EQs9uW1GOw9douAkgUM6B3lgDqx8hLy/TB10p4f93TVaZ
	 OYLPggULzjvQSUX2ttfO4N/xW6ZCoxRMDktS51IPRSXXcd0kjUKlEEbLbjD0jNyoy
	 fpBEBQnZiWSoUae8cGQVMEikWGPzQnkI4UounQ6VRsBkT7pJFfB3scjadoaM46T9T
	 sqoBWiptK2yUkIuxatftOcW6PzoRAy4/uaFyK5iaFP4iENIKEYd3wq1iskjlsyubt
	 xTV1MrUL0JPPBEuvt8VR6JR2D6Vusmr6xpYBtVHGDwFmTI6tFdrHKyKGKHlYxt/LV
	 jt8SZ0SiE53aKY//nQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5jv-1voqtK22D3-00DNK4; Tue, 03
 Mar 2026 09:43:35 +0100
Message-ID: <f84ee498-d9ba-411e-9861-c6852113cb19@web.de>
Date: Tue, 3 Mar 2026 09:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Gu <ustc.gu@gmail.com>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260303-ti-ads1119-2-v1-1-19d31e69ec7c@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1119: Drop redundant error message
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260303-ti-ads1119-2-v1-1-19d31e69ec7c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:b8od9isqubo3twfiGZLwqRi0JLtHNtMecKJEH7lha6og2lhKYb0
 ngsHaWw2msc74KXwHxXIvCdkSgIVsGKwrCDOECKme5TMp4BBst+bzhI2UFc/rhZd4+R/CVH
 /sQ2VwT63hiS1ipr88bhAYg+osC/G3bZT1Nbj94K7beQl3yGE2oEYQcCcWlkgDMSEDKjRwq
 rgqxjRO/BAb1UYMdSQWbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v71BeEOhNy0=;2OchDwKY3jadMo4GT4qXwLz7Xsb
 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
 jqLGTHahrFvVqMOkrguZMNblTbwl+AYhzj0gQo

> devm_request_threaded_irq already prints an error message when failure,

                           ()                               on execution failure.?


> so the error message is redundant, drop it.


Regards,
Markus
