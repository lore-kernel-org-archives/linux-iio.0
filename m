Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7BC30E0EF
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775992; cv=pass; b=Siug+omO7gLCTpSlhpvR3aZ4bzXYInIMh1hSjXf2EPmJG2CfsMymIOSDRj8r4ZyNLaxCh92IuqFKZWHMdtQPnh3zZxNmZggioNmy4Oo1HTzjVhOX/TkSfKhtKmaHBliNpATCjWA9WuPop1eholWr2nVqlPuvdyJZL2QqmsC56cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775992; c=relaxed/simple;
	bh=+KHDcn38GfU6WeawWHHySi9qeZYM6Uvj0nVpY5j54TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dp7y91ZEexuJ83qMhR469kcsSR2wBn+pzgGpSkmYh3dDY3/YbKoTJWh/rkYxw0MsUVmD55yOQ6plwsSkpQ47WzH02qvdmqABgu+ymuIbW7zUMO+ciUaiVZ5YtXa9YS8eJP5dAtrpCzfbMzvbw/8VyoprzWjvP8/kWrbyYdGHGeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qX7pSIvy; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qX7pSIvy"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8d7f22d405so725041566b.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 05:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776775989; cv=none;
        d=google.com; s=arc-20240605;
        b=TIa3bMfa9+8Lf0MqlCKlMpa1bW8aD9V9AYSQGjQ84A0gf4nSabXoHGhr0vJCYQ9yXS
         eVJplkvmuG7aqzuaZh7X5oYxafZGEPEpb7UdX1ku04E6/cKRtjBaCD3IZhYGd6cgr/Sb
         WkQPno6q/+m1IPF12Pcdfd0GVHR0ujHnlKFCk0YjsX8BDG8kEqq5Oj1XvKwH4L1KGqma
         jXYMK16hWc/XcY/T3VIS2mLBCaHjZMsj+2RtVq224zr3bVj9ZDoVaFuoSI0oxkAfqqzy
         DuOUlK/mSPjD5gAYJ8MIfSUNa4YjR2isjk2Ho1yxvKWg9EfBPZYXLZLHlVQlweYk5uWs
         2NPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KHDcn38GfU6WeawWHHySi9qeZYM6Uvj0nVpY5j54TA=;
        fh=mtF9VrY4nEriFbp006bcQQqI9N9XwsxgOp5xTxjX+Xs=;
        b=kJRdaSuIPLKuypmxZIHHJvq5Jt+iDh8Kvgc3zwqWd3NqXZ5kCTSx7qldHi+RqbRjx+
         usd5PKzyTx1IlYTTk/FUDcrLeN076KddxsBt6EVaO0OmFGPRkIMByC585crD415rJ197
         mtECgIfY842T8FHDAZ3iI3puUQWctTFoWQ3YmdJVG84YdFSk1c0pkaxz5OZpk+rHYzcR
         /v0VKax6hnakUMfZ+YPkCCB+b/zJ8ZNs83q4M1TrodEoq+hwZ5KZJDHVuW9i2G6KpDd6
         iCFf6+mWkWlceE+WWfW0201G44bIQKrcmIJ7zumXj87CIv9EWALK4apNWqDpLswS3Vo4
         6jEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775989; x=1777380789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KHDcn38GfU6WeawWHHySi9qeZYM6Uvj0nVpY5j54TA=;
        b=qX7pSIvytrp7f5bjLJyEx3cX2kvq9/oZjDOQrRqJD4+bXotqVJxFj21SKyDsZRjfQf
         2HFx6NwY/gXx9+qOlUoTZUgdPjzHFlFJKcz7nu1N7H+o0cthitAzLhoivcG144oP/HYk
         2TN49u6LuI8qDHugVMiJQe0ziFstM+HxQrF8O7iy/30BZiAwEyAAE5FZplx8kaaEkkxe
         x8TjdLyr1wksc132vbvzrMHdaj8HGc7ZqV3De4A2uGMtWWU9mRRlpA6HPR8OcIEmr0qR
         6EEmkpa0kD3cr7YZ1HBno8eEKm1lbnlIs2462GdHYta2imSqVzQPbduuipQZurjZG+zz
         W3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775989; x=1777380789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KHDcn38GfU6WeawWHHySi9qeZYM6Uvj0nVpY5j54TA=;
        b=G4nRLWR6c2AUkBcsGomv3ys4Ar4LkAQJtjVN11HFp/wEBvS1dVJmL4joK4+3OFZVNJ
         5aqDOswaKR4/Gpc1LC/LfKZp0kWKHtgkUHU6wJKUTAPIWozIC5IWrvpSFsOcCse4Ep9O
         M4OF48NPuJVvrZmX4bpY+n40wAXkWo/q9WDHauwNywDQGnapjjOOuwGnteYvfW8IIzOn
         Cakv8yT1QgwurrEon4volCCxeQbQCUdhwuhV8v24ixXtDklfklavgD1Jwrx0awfhLa7n
         PwpxzLseQ8eEmz89b2PIUEcrJ8GpkwEurvZGn8WBUAQHtaB1Hf4j4gyZJuoTrJi4aSDp
         s17g==
X-Forwarded-Encrypted: i=1; AFNElJ+ElBJowVPDAPKKyvrQydwOqAqrdjnBj6i5sdoDPKq/+aJsIp6izqyO9jP1WO4yDoCjU0IGyELXq9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQd8MQD9kPa9eVOSoxTXSGgsiHcUi30B/11/VItiIVGOFmrKx
	4RN2E3THN+NdXdDJUCz2gcirzwxpveJIvF5HqNbva+A+4VBDP3ycLPgnWonEvNtk0YioxBmNbew
	w5KkcPZhF72chgBoPDUjTAn3fsf13L28=
X-Gm-Gg: AeBDiesFfF7KyNU9MVMP1dnXMAgvdGYC+wc2c+sP4PPrW6Vb3LGjfrE2PCFjSXcREY9
	XQim5yjiZes5G04VPCAFzkV1koEtTab3nKzsgkNxFaeT/PYsVo9HBGd3DGh1q02WFhcvuifSL2I
	Z3Uq/Dx6TOr62FXRufB+WHSiTl7aNBlxC8J+AkHWGHp7Jhsw7dk/DjXJAQN2vN9Glz0AWjxuKot
	+NCsbbIhgiV2mZ2mRU5PIasV+aznP34cvsj/1V4pMd/wbxRddwRVlRmYunoOTfw6jbxMaIG38S1
	9sL6uKIoUcaEFoHC5itAbXTgIGYDLh5uJUB2tpq2Ds9C2EUIqa8BhE1rFW/AXX3c17ZC9QSk+CT
	UnGvtjR91w30sApyC+vaLYt28hS+D
X-Received: by 2002:a17:907:a0b:b0:ba8:bc46:1fe4 with SMTP id
 a640c23a62f3a-ba8bc4622d5mr252341266b.19.1776775988573; Tue, 21 Apr 2026
 05:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421021023.563290-1-rafasales@usp.br> <20260421021023.563290-2-rafasales@usp.br>
 <20260421111919.5ad809fb@jic23-huawei> <CAHp75VfVB9qQeX94Hvhv8apa-gzK0anmE6ox5wzYK8oVKGgzMA@mail.gmail.com>
In-Reply-To: <CAHp75VfVB9qQeX94Hvhv8apa-gzK0anmE6ox5wzYK8oVKGgzMA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 21 Apr 2026 15:52:31 +0300
X-Gm-Features: AQROBzBiqH7oW62v7OVe1PMHFeBCjAV43oU8mFsmhFdLrQF4Hi5OMp31vFRl7So
Message-ID: <CAHp75VeYU_GXrOZL4SkpddgAfibd0NUtxZxa5ELAb=y_2+JzVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: light: ltr501: update header inclusions
To: Jonathan Cameron <jic23@kernel.org>
Cc: rafasales@usp.br, andy@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, "Gustavo C. Arakaki" <gustavo.arakaki@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:49=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Apr 21, 2026 at 1:19=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> > On Mon, 20 Apr 2026 23:10:00 -0300
> > rafasales@usp.br wrote:

...

> > > +#include <linux/err.h>
> > > +#include <linux/errno.h>
> >
> > It's a bit indirect but I think we can always assume err.h will include
> > errno.h
>
> Yes and no. err.h includes asm/errno.h, but linux/err.h. Strictly

I meant "but linux/errno.h" (that includes Linux specific codes >=3D 512.

> speaking the use of -EPROBE_DEFER along with IS_ERR(), for example,
> need to include both. But I personally don't go that far (I do not
> require people for this particular case) and do not prevent them from
> doing such (when there is the case as per above example).

--=20
With Best Regards,
Andy Shevchenko
