Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616139EF39
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638901; cv=pass; b=U6k9j3R0E0HS34nLsSwg1kWnrfuZpB6iL92ieldCjpjhBarZSPGEb/MsYpr1ZkdEP6QUJqJn1vIzF5GqFKrgffmMBwSE/QXwtfO0AoiKhE5+ZdMdnPtR/8lMWlSAcIDigtNrA1BZbVw9yIBHxIJPgB88ThHBvX0ObCesGehHLy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638901; c=relaxed/simple;
	bh=Ju8zPBoyv7iefTqZFUcMqMsY8QYQ50TTbErq1xhjHH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgrLcSxEHBoNPK9LrrSCVZVcUNOsTO6/duH5aPrXVKx5K63F+nzHgJU9OyGySvoXLWadcs8Ing2WG4BTXMRFea8HjRaGvGga3X2qThxY+dI9r6k7YX1dytwYumLAwZ1eDb+9hEWNHL8GFAOwzcPdgGlRzJV0+DpW0T4E8YPsvx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCg7IMwv; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCg7IMwv"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso277853466b.3
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 05:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777638898; cv=none;
        d=google.com; s=arc-20240605;
        b=YqSQRm5S+/gHgNiE3xN6V761jmknOeISZfMWd9/4gYxY1fbpOij5kQJ2Fa3fHRtoT5
         WYJzVE3+SuDV41DZN7Rm490F7TKsZY7APwi4VxY9yRA67FluVxY3eOPr/LzE88ggWiCL
         k1oRx6mQcX8Fyg1jyhM4ya1ket4tZbr5GMNcf7iSP7IUKBlY7uNKnC+BBuPZaDbvlO55
         PBQCI/S9KtamMSbtJMPGsU+JN/K9nIV8BWbOx+cLtSWCrI2u7C4tpjffuWeWgzxgPgBa
         8+h20/K4RBomPsUK8TtbZxxEcWBaK+yR+51pJTmVOiOj3emmCWRsvjG8wPe29FQnJFoS
         5tHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qpx2v2crex3gyZcr2eqVrPJtmJOpEkyIwrbYh1NR/V0=;
        fh=YJFOWhK17o8vjdXVKTBr/UXXiYZZ4wTtI9FbuvS1B08=;
        b=AAAhakc7Ov3fIEhWewIkWSCGfrOU6wOQVkkfovaOQn8jli7+2yqOnVoOp3YJW24R5I
         D7B9IXTlLmei4xvUqKq+dwjKyUGgTxIsjv7497WKy3ycJd6DzkbLxe+OJP3Q7eT6rjia
         gSlK8Xqo/1COx+0b9ND4Nu6iCAqjtWMY3IazDJxETi2WODNLxEitRuBe+vtzhutD0iRk
         RLPkBMNnJiYLh0LfvTxC6j9CEd+Ae7Wzx/+M2wPe4EplzYhAs7RqpBkIO/6O5LX1DnIj
         /+thy6ak7W4Che791OVPhrpuIBBby3oL77S1igQqTKDo4tSFx6aYbMV0CB1EJSkQimYb
         0D0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777638898; x=1778243698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpx2v2crex3gyZcr2eqVrPJtmJOpEkyIwrbYh1NR/V0=;
        b=KCg7IMwvPY+2Ojg2DmhHT4kr9P7rXFa/g+10jVVIBmhlGzjiTdYNEy8eSZxECT7Qqq
         WtN4zcg/smUfqmCPQEGUgg7vZbfJJpVJV+wmpcoHjwqMgYdTJrqyalq3THCgrQ70J3sr
         B6W/6h6vgJeU34jYXJdKN5p3Ci8nFBkApdtPKtA1FuyC2aWnnVVjrWmVuOX00XUtRPZp
         x5kQkbc/nv/cBj97QsoWuk9LlJKWVAr6IQGYXndFkW5ImaKnOlAKIYVG1TJyk2ct1GkX
         7nliBFYeETys6DFeRUFt0y5JMIxZiAJV483PUptA0464Xbd/JaH4KbBKM2vXa+Ey1MLH
         vGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777638898; x=1778243698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qpx2v2crex3gyZcr2eqVrPJtmJOpEkyIwrbYh1NR/V0=;
        b=rJy5MsR5qwnOb9AGXvIv1opA0utxCqDIpnG+/CxYmt2DgUbQXbEVHHMntxYFlfqybX
         KzBXE+nEmSzMbCljrQlv71fOsXcxAg8kDM/V98fXw3A7DFxBH//ujuoo3SXCzXO+sotd
         vBq5znk1GjsFI0+g1fY5nmDrbvj1HDgxP48phekCe9SSAhvEK0l7emTWaROdmCuwO9FB
         Ub/yIJirh9YkFVI4MPGwafSYRg3VSDjrDHFeyyPeKq1Tm0KNuwGZV6WsztHsllAxT4rl
         xkknQpBy3+IX3OvR6sAwDYrw3rVEta5K5iqWmB/Yn+sA1PdmjBcbwOvcXG5WoxMWHRWu
         ZDOw==
X-Forwarded-Encrypted: i=1; AFNElJ+E6q8qoinAuUVJl00qd3jP7vHgnBW0eB6v1GY8igWdiVi5GSa/E7J0IBT5bokrr5v1JieJqUCNS9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqIeP7t5zRK4PAKJNFt3cVF6WbRFalsN0Fzr5kuO91kBaPtSR
	nQ4AsAZHxJ3oPYFtuhb14idhZdn8AHgYkfVzxDSd5jSVGQ0a5CQtZdmgK09HKzGAA3/9n7pcysC
	WRH9aiHNJCGgU2feEbVE+tokXFhw3ZBU=
X-Gm-Gg: AeBDievgFGEFzVAuPqIN6l58rbKDEr/DrDZ2zJiLKEc9bcRH/UqbqQiTDQhULtMEQh7
	sD/EhbVZOykNjSg36EsIsQ8JHe4pqxOi0MTR5jQ+ZCVJgNg9CUAMH4FOefMeZqhZGyWkntnHFow
	7C1yVM5158Iu02PfAxNRd5ngOtlFLh9AbhHnmg9VpdVHyzvsEdNOjqHJmr1Vmi09Lsyq1+aqfDf
	Q30eLceeSictMSWk6fV0N29xj1uawgQDuzNz9eJkjRIbf/0M6Yn/Pk8VCb6D+snW32r8JmmdEj+
	n1xK7pB8fKv17Wr0CZW0q0WszCtF43ZysHMlbX0DhQWQxYsdxS9GUtFW0JQXM1DNtzRxO8JF7bX
	VcCnGQ7spKg8z+Id+yg==
X-Received: by 2002:a17:907:70e:b0:b9e:f58:c581 with SMTP id
 a640c23a62f3a-bbac8279454mr425610766b.45.1777638897805; Fri, 01 May 2026
 05:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
 <20260429175918.2541914-3-sanjayembedded@gmail.com> <afJcj34Fc_aUMVhe@ashevche-desk.local>
 <D8E78026-517D-4CE8-927E-6F4AC7E21454@gmail.com>
In-Reply-To: <D8E78026-517D-4CE8-927E-6F4AC7E21454@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 15:34:21 +0300
X-Gm-Features: AVHnY4Ik6EO_c-m2FAeYZ7zn3flnVR2Cxw0BTvJ6-MQWUxz-I9e59ZOS6vfn9xY
Message-ID: <CAHp75Vd7PZX1Hnkc7SwBrWDa73k9M_FJobzqYjr6WtT_d8+yow@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: hid-sensors: introduce device managed API
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jikos@kernel.org, jic23@kernel.org, 
	srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 10:30=E2=80=AFPM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
> On 30 April 2026 1:01:27=E2=80=AFam IST, Andy Shevchenko <andriy.shevchen=
ko@intel.com> wrote:
> >On Wed, Apr 29, 2026 at 11:29:16PM +0530, Sanjay Chitroda wrote:

...

> >> +static void hid_sensor_remove_trigger_action(void *ptr)
> >> +{
> >> +    struct hid_sensor_common *attrb =3D ptr;
> >> +
> >> +    hid_sensor_remove_trigger(attrb);
> >> +}
> >
> >Casting is not needed here.
> >
> >static void hid_sensor_remove_trigger_action(void *attrb)
> >{
> >       hid_sensor_remove_trigger(attrb);
> >}
>
> True, the cast isn=E2=80=99t required. I kept the typed variable for clar=
ity and type checking on devm_add.. API which pass void * callback and remo=
ve trigger API which has struct hid_sensor_common.
>
> Happy to simplify if preferred.

Please, do.

--=20
With Best Regards,
Andy Shevchenko
