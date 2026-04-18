Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85B1C5F1B
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776541725; cv=pass; b=hKx+ETA/O/ji0D/+H8URjI3phS+u+6ZkmBg8FZ9PC7sTxW249F7CyJ3QAvP2avtJKn5Jl9ulWI6QqtBnm8Jyfcf2L8W0Rv3jyyjPU2FoFQTbXchBm55SOCZPdKhr96RtDEB8xewwLGMRGoTh3ftY71Khw78BYprKa6aJM/DyC3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776541725; c=relaxed/simple;
	bh=QNnjirEE9+taUl3FOqtm3HUbAhNxM6+8spyvJkRd0Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuSVvSPPGR0Ul/0nOUMxOBv47WobT2Hj7D57cAVGTC1SlOBC6Duf0EiOFnepB7giITAWFLJloo7NOv9bMA9qR/AKRZnIE/JN9BW/WVc6za16LIXCbmwWgY3frJEX3ratfbsqRVArlkld6mvovyP+fMrPSP1cz1Ivdio0JdJEIQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJHFIscF; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJHFIscF"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d70c30767so1571879f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 12:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776541722; cv=none;
        d=google.com; s=arc-20240605;
        b=L6iJVKzn7CqIKplc5XDt92rIWR6m/pcx7T0smTc6gFg2e1YSPaDP6eKniNl5BxIIwM
         cMCBX12MJ075bb1WwIwdI+9NeCWAtjFkrQ6zvQhDWG0jkC8HsQ7r/kmpqXnjjR0Ak9AG
         fczOReYWLTp4J82EsiT2H3KHPVKww7I8Od7HcbTyZGVQ3sxH6oWRIpA2G9VujgI4o5fw
         hNJkVvNkKibupOLa6RQtYkZidt//h5tcM9BnrnuvIps7XdZOtZuCUrruWAD4b7xFsNnj
         7Q7IXY0bhmBxrXQPko8gtMlJzm8975BADpXxGAE+vsjbBZ+Rc/SRUBaghKr+q9nmocni
         9K5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KfNIvP+kGakhsVtQCOsk+NZ8Rg4P7VrKNiU3gLYB2YU=;
        fh=bP2DTKc3Y5M5//leJ9A7sBgNzKb/Wr1+1TTz6ZPLkGU=;
        b=Xfmo/P+9DZYx0Pdx8HqHk+ky1g5512Ic2crEpK8DjC9Fz6URFP5Q+Hzgv0U6WV5Nnx
         kK9Y5Dvn4oTlQGAYSTCOngQRQqGvsrLSPcUcXI32xb/5jx8z+feHeZnO9/ZvDDq5XjK/
         r0TFo8ZXYqRoHO1LBCi/f9D+vzUzO3sGmPYURzfYZCJeebzXHC8vQVZ8phUy3h4uYou5
         0Mi+Fensibal86PM1wjEhLa+MFVPhD8bhfy5f1bklg95K5VwDmCeGU+33EEhZMf9Lr1U
         7/6H6/hFdv694u2YopcTAbhYITC5tvw07WB/UTZOA4G/GtZukrW1vj+WPT0eZVlNdaUN
         k93w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776541722; x=1777146522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfNIvP+kGakhsVtQCOsk+NZ8Rg4P7VrKNiU3gLYB2YU=;
        b=jJHFIscFwOGbr2nIUSFFZqnEcSGC7zuP+sc27v9AvaE8SZ26xYQvKuyis5oDl/b5bP
         YoW3UnjvSovARvlKMUz9vQWkN09uOcODvP8zeLy3iAM+6Cm52CX4Yr9yZA7qSZls/4df
         x3Gtr0ilaFx/nLUvAQmPW5vuIg/b4GAH52Dyt55ZpOCAwfVzvW+LqPbiLC+IIw0FO+MP
         J7jdmSU8sPBLnQQ2lo02+o/YCshDtjWWdZU8kKkSXCkOFzhNOl1yiX+N66RA8B13yWRJ
         kOB6COXhkE6xx8YBbz44F/lWBerSrhbZbEilsJGpK18E4poa1vENZdJhUAb+KqmS4yYs
         rU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776541722; x=1777146522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfNIvP+kGakhsVtQCOsk+NZ8Rg4P7VrKNiU3gLYB2YU=;
        b=MbzRGQYFbvli8b6M6CdbZESzBsmfIGOPSzyB7P30nt4zYx/gGXKaDv2EmywYFpznaL
         fBWm1n4J5beETXZZsrkmwn2KfWfbKD08hc+A0XwDI6FdJtZr44LweYbndPqGt+sEjTs4
         qDppgr6hE+BSlA/Vi0P6G7PdsmRX1xsF5M8MJ9T18zKPL81IQtaF5gLDtT63ivrmWFWW
         edcSwiFyMrWyy6hR2sZJ4R5qx374yiDq6Cfv6uy/7FgzUgaPUGXMAPP+qUjywagfryxs
         7020lf8P3il4q0EBNlUqRW8qlCV/0YYBci0MNxeRgs9HVqZf9oSiPNjkixNAgiiSo3uy
         Hs5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8fbgsQdfHMQlKk1B3BkNrUFJQGcxWyfKZhSaWFJJwEekRrGlrEBTpqsXTlKOs+mHwkY7WZZqBFq+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRv3BNRkK8w3txRkdx4n2xboe4XgQyxWOiaSNe9XBGdxWTr5yq
	Fc0OwUmMldBQvzOYr/v4Z8r0i5t/oziYrSnzX/ZZvOrzjbifv8hek6db6JPXtF93WJXYYfm1N7m
	/HvClu+WSh4pwdVDY2kKqS10AgW79OkQ=
X-Gm-Gg: AeBDiesiTtoNlZ6AxV63/yeuPyN8/77pLhxpL4yDfiAnGvW0f84qyS9/1tf9j2YrL4Z
	erywEdGsL/hYNzgL8EAI+mI0zRhp55XZR3YFPsd1Dr9TMAdya4sWd+cei86+XY4H0Jw0f871z2E
	xN5d61eWjYmAlzDT8rS1ArBipMpfYQrsGGGPKnjyCPGL77Rm2oeB+/g+8LlC3PC5SLJjooUcLrW
	ax+1gicYg4iwhccXfgbx0IraiEvbVjB4rlUlz+IP/yV5L3uxjKG9tj8/SG9S8m+O4pF0YiK7DnI
	RVdwpGfzgja23liiMkI=
X-Received: by 2002:a05:6000:2dc6:b0:43d:7512:6f7b with SMTP id
 ffacd0b85a97d-43fe3f35785mr12170312f8f.5.1776541721541; Sat, 18 Apr 2026
 12:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418144716.132936-1-clamor95@gmail.com> <36e3611d-642e-42de-9a56-cf81c3e06832@baylibre.com>
In-Reply-To: <36e3611d-642e-42de-9a56-cf81c3e06832@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 18 Apr 2026 22:48:29 +0300
X-Gm-Features: AQROBzCxF8i16JN26FDAkpF1ordk5znfDFdpoQnWkq3YscwGp4AejBpZy9piygU
Message-ID: <CAPVz0n1ph0Cjw9WOqoVPaEywF0MzaNXeEjw6=0rKf4qLWiJZtw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Update APDS990x ALS to support device trees
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 18 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:2=
4 David Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 4/18/26 9:47 AM, Svyatoslav Ryhel wrote:
> > Document Avago APDS9900/9901 ALS/Proximity sensor in schema and moderni=
ze
> > its driver to support OF bindings.
> >
> > Svyatoslav Ryhel (5):
> >   dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity
> >     sensor
> >   misc: apds990x: Use more device managed approach in the probe
> >   misc: apds990x: Drop Vled supply
> >   misc: apds990x: Convert to use OF bindings
> >   misc: apds990x: Drop IRQF_TRIGGER_LOW trigger
> >
> >  .../bindings/iio/light/avago,apds9900.yaml    |  83 ++++++++
> >  drivers/misc/apds990x.c                       | 197 +++++++++---------
>
> As mentioned in my reply to the dt-bindings patch, there is already an
> IIO driver that looks like it could be compatible. I'm guessing that
> this misc driver pre-dates the IIO subsystem. I would have a look at it
> instead (drivers/iio/light/tsl2772.c).
>

tsl2772 driver fits, thanks for pointing out. Maybe you know how
apds9930 lux table was calculated? It is quite obscure to me.

Obviously this patchset is obsolete and different set of changes is require=
d.

> >  include/linux/platform_data/apds990x.h        |  65 ------
> >  3 files changed, 187 insertions(+), 158 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,a=
pds9900.yaml
> >  delete mode 100644 include/linux/platform_data/apds990x.h
> >
>
