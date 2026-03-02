Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDF396B7F
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446445; cv=none; b=ZdoTHPnuPG4FzWdLVkZPqYMn3iTVTFmkmGyfkrbjNs350rNxa1QSunc3SceKhA7ge0pEBE2q7OJ/nxpIS6Ay7Qa2P3mEuQfbhEtAF1xzHK4zBl2aHEscBi87h814yMEkvJXape+cwP88+BElXkDEEKstOmiHbmMNKEYQptxCTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446445; c=relaxed/simple;
	bh=iLH8tcewwnAd83nG68sHys9PIlmAkraa6eQd/lWE/eU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZE7gGGup6FxEtBltZm42A7lFjg31P/7shT17kp0TuaDIvSHAA9bPSThjxbP6ZtD7l2WWXMXQJHE632V8Mu4ZvM1c8RukfAc6b4gGwF8PqK+nUMbBzY7JCnI4hzJFCpxtsASAms8EL00GyOLNwcimfzS1rV6gRI/URLnZbNslU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbvClqdN; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbvClqdN"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-897002b7576so65925616d6.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 02:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772446443; x=1773051243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F0R0FHok1ZjJPUxXlY2o5kEpjOjt+LYzwp5EsM9Prls=;
        b=BbvClqdNtmqh9LGy565JTqKiOYLDLIdlhtOEIH4bZ5ueICxH+z+mDtPry+luRLmoYh
         vRX8jaB2Z9nEVdBT5aGZJARvV6Te7lHpzBitc8B6h+gfQzoTcmS7hrnyHkWKtztoC5cW
         2yBunDRtpwtWvxLDtziyiw/xrK/XCdPcyYaF4VRx0NUySSUq50sFVOaAIpk4i1Q20iq6
         1C1Id0rEehMwG7dwcejf/+0FUjZcje4JkaS/neusKcTRtBp6q7Eu+kxGYxX3Eg1iFGsa
         rRWI74vi9K28PsSXqpBjj6/d4xEKFQPMnpBBtYKk6ZAk44iwImyn5wn4NDgo9EnedM7+
         44IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772446443; x=1773051243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0R0FHok1ZjJPUxXlY2o5kEpjOjt+LYzwp5EsM9Prls=;
        b=DELj9hGubTiTO8PZMx9A7ulXftK5Q+8erXxeFKE4MnXB14PQTqDxG1M5znOwdNr9MN
         6O+XLLfl3pEJf5Uwz6o3ZJFQ6Y27thyOHpe83fUaRF0AWZXyN4wL+dB1j54nJr63/mYB
         aUt4bCpoHNFn6LMtGFlWT2Ql0lclIP0MVLDfdOMIN0ACXlYTLwXNFcL7rorCp6dlo65K
         KGSimXYeICKse1rIl26khbNIkmwbqHpgocdl5naK8R7X0y0+Jy7OPL7bYaYpzWVUyzSB
         8d/0XjYp+vAxSYzlQAVupTGnXEKgmGM4p4dQl/fp97KHiMlZJQoFBZNP6SA6nCdPzZzz
         CDJw==
X-Forwarded-Encrypted: i=1; AJvYcCXeJzDgLYSrrfRvt8eaw0sURKycq6ULTaMSE5FFkJrC358wEmw7JJi/GGldgI6tr34oW19w89HPshE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoukq8ONjAJ9rtOkY0GG4BfjoaH8IvktyVmBpX5cPPRKRKTl9O
	kjcPj1+VAW+HW7PmcahhS5TYbQc6eFnhaTndOfRMYKbXbFDnRoxhq48E
X-Gm-Gg: ATEYQzwd+vAHVyO/Fz6DZnUWUSCgastMCghxIl//oKvS7TCdDIgBI+58bvJdJ4reSul
	FSgXQtgn7AuGqchBQXXPXqS7nhp8inytm+4EvH0vwWihWATM1tAWooInJT/VJ16xbqXnsmCrtLf
	FpkJ2mZxrH059TW5Rq2iI8BYCe/7irKGXdiSis+ycq185llPM0YhtYT856SKv121UgZwZ1vH3EU
	9HBAkgb3XHvVzFrKgwzy4yYgmHdhfeQ0eYuxNJdXq6R3ydIyrx/+px7eZqTwxX2rL1zjX70Bgdu
	AX0uAXmehCKZe5+lfXlnqlMXqsPkNK1wUeMWKfEs3UmEFL2iYV4stY1/NuluAN3VpX4KDwPK56H
	RARVHiMaqwD4brYVPph5zqkQ8ydbZZVRmdUWCzlbdGumcYhH/LTd55LtbDCxLmKV1WqWZh5wNEM
	K0GEGOJFOo9WQEzJTUrxDEQdET4DIAcuB+dY6Ym3a1RkL8r1LTAZbABQzO8Uy9cBf8JiWlfdciz
	odu/QmYRFL8LHc+TZayfsD52KFQjvrsuoTi84CLsgciqelsyLQ=
X-Received: by 2002:a05:622a:4d:b0:501:40af:96bf with SMTP id d75a77b69052e-50752989987mr166147711cf.68.1772446443158;
        Mon, 02 Mar 2026 02:14:03 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449a66f1sm114236241cf.12.2026.03.02.02.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:14:02 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 2 Mar 2026 10:13:52 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH v7 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <imtqtaakbz4c4pmlmb3gh2r5sjvso2fymdy4poyjvds2noqzdr@d4ia6rml6jzf>
References: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
 <20260216-adf41513-iio-driver-v7-2-b0ed387ab559@analog.com>
 <20260222172912.60a103c0@jic23-huawei>
 <aZwYshRxNgSh3CWk@smile.fi.intel.com>
 <zb752y7tnjzsc35na572o4sip6efwv3i4lha4ls6fhdrr52h5v@bfgy65cmae4p>
 <CAHp75VdSV2QDMR0DueCuP=Ds-5A1NsNjqPWtmRbG4NvoJ=LjXQ@mail.gmail.com>
 <20260301122340.3fedf64e@jic23-huawei>
 <aaVKDbB_XIFmxCEM@ashevche-desk.local>
 <ct2r5wvvfowqcfe44fawbi4blkjpfle7etvaunwbsxevejsr2s@3g43wru5n6jh>
 <aaVZdgvZhaWDgU2X@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaVZdgvZhaWDgU2X@ashevche-desk.local>

On 26/03/02 11:33AM, Andy Shevchenko wrote:
> On Mon, Mar 02, 2026 at 09:19:42AM +0000, Rodrigo Alencar wrote:
> > On 26/03/02 10:27AM, Andy Shevchenko wrote:
> > > On Sun, Mar 01, 2026 at 12:23:40PM +0000, Jonathan Cameron wrote:
> > > > On Mon, 23 Feb 2026 12:41:45 +0200
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > On Mon, Feb 23, 2026 at 12:37 PM Rodrigo Alencar
> > > > > <455.rodrigo.alencar@gmail.com> wrote:
> > > > > > On 26/02/23 11:06AM, Andy Shevchenko wrote:  
> > > > > > > On Sun, Feb 22, 2026 at 05:29:12PM +0000, Jonathan Cameron wrote:  
> 
> ...
> 
> > > > > > > It all depends on the series from Dmitry Antipov.
> > > > > > > Can somebody help reviewing the patch 1 there?
> > > > > > > https://lore.kernel.org/linux-hardening/20260212125628.739276-1-dmantipov@yandex.ru/  
> > > 
> > > FWIW, Andrew picked them up for Linux Next. Please, test!
> > 
> > The patch looks ok, but I am not seeing it solving my problem here.
> > Here is the v8:
> > https://lore.kernel.org/linux-hardening/aZXDSbyH8tWmTPPL@smile.fi.intel.com/T/#t
> > 
> > I would have to use simple_strtoull() and it would clamp the value at
> > ULLONG_MAX in case of overflow, but it would not say that an overflow
> > happened. Would that be fine? I understand that addressing the FIXME
> > in simple_strntoull() is not a subject of this patch.
> >  
> > > > > > can we push for the exposure of that function to kernel modules?
> > > > > > We have discussed that in v6, and I understand that:
> > > > > >
> > > > > > EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");
> > > > > > in lib/kstrtox.c;
> > > > > >
> > > > > > #include "../../lib/kstrtox.h"
> > > > > > in drivers/iio/industrialio-core.c
> > > > > >
> > > > > > is not a good call...  
> > > > > 
> > > > > Yep, because it's a temporary band-aid. The proper solution is to have
> > > > > shared code provided by the lib/. So, the wrapper to parse 64-bit out
> > > > > from the constant string literal should be part of the lib/ in the
> > > > > result.
> > > > > 
> > > > > > > When it's in, we can continue on this one. TL;DR: for me this is on hold.
> > > > > > > But if you see the need to have the driver being in IIO, please add a big
> > > > > > > fat FIXME to make sure we will get this all being sorted out in the
> > > > > > > (nearest?) future.  
> > > > > >
> > > > > > I could add the FIXME into iio_safe_strntou64() doc header. It explains
> > > > > > the context:
> > > > > >  
> > > > > > > + * The implementation of this function is similar to _parse_integer_limit()
> > > > > > > + * available in lib/kstrtox.h, but that header/function is not available to be
> > > > > > > + * used in kernel modules. Hence, this implementation may need to change or
> > > > > > > + * removed to reuse a new suitable helper that is properly exposed.  
> > > > > 
> > > > > Up to Jonathan, I hope we can move the above mentioned series forward.
> > > > > Without that, as I pointed out, this one sounds to me suboptimal and
> > > > > unneeded double effort.
> > > > > 
> > > > I don't want to hold this series for another cycle, but we are still
> > > > fairly early in this one, so some focus on moving that forwards seems
> > > > sensible.  If we are running out of time, we can fallback to a loud
> > > > FIXME and a plan to move to the generic version in the library next cycle.
> > > > So let's set a rough deadline of rc5 and see how things are going then.
> > > 
> > > Taking into account the above, can we actually develop something
> > > based on that?  Or at least having a temporary solution for this
> > > cycle followed up by the better one for the next?
> > 
> > As mentioned above, I am not sure how consume what Andrew has over there.
> > It seems address lib/ internal stuff. The interfaces are still the same.
> 
> I think it will be third time I'm repeating that this needs a wrapper in the
> lib/. Just add the one (like with safe_strtoull() naming schema) with properly
> formed prototype that returns an error and the result in different variables
> 
> int safe_strtoull(..., *result)
> {
> 	...
> }
> EXPORT_SYMBOL_GPL(safe_strtoull);
> 
> (Also some test cases have to be added.)

I really understood that I would need to use Andrew's work as is, but
in fact, you encouraging me to add what we need on top of it.

Assuming that this would increase the scope of this patch series, I suppose
that would need to be included in a separate one.
can we just not export simple_strntoull() from lib/vsprintf.c? I mean,
addressing its FIXME and changing its prototype?

-- 
Kind regards,

Rodrigo Alencar
