Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69B3FF88C;
	Wed, 27 May 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900702; cv=none; b=URAynbjQ78tRKKXHu15/2Hqh6IxbJ4CNruCnPdiT6g1gz6nUpNnG5fn6s6GUgdR30IkbNwppc+lfBQ/nvkTGkxiP04Gt1/jSOLc+D4bPlN0YHXk/pGEsg1lkxtNb/5hXPHL4XpP9JU1bQKYIe/JFKwg1Ggr9DrS+ZPXaeA4vnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900702; c=relaxed/simple;
	bh=vZbNS94ZzoRRnZR5Ea1D5k7DS8m7jRAPEPhTfGFYoEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/fhAJ4kHWjEd46l6wEbEIzEtwzxrZ3damnqO4wp/RpyG/+oY/R5N59aJMpn314BVpUDsyIWeqQ4gbqR+f6wh0ARU+sVCHzRhmkTTYumBTlowCPAmajIJc69Kt07GsR4O6KsNH28qJT3P/4Usn3vHCRB39+PNqpBVj93YAEIE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdAMj++X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdAMj++X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABC91F00A3D;
	Wed, 27 May 2026 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779900701;
	bh=xPuKaQ6LkAu57IQk1MSOplJ/wTZxrXsyihPoJdrfBhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BdAMj++XK14QhyoacDbvWPzGJ4NqXEZW4fZ1wAfOOWp0DEc5HHwr2clui5oneaWgy
	 5cmwcVgKHlaJWIopEgOWRkffsIymf8BsWpPFudyLpa1CJQsYzP6dPny3zFK0BAjP0y
	 wLgU7UQI7v8KyTAjjqWpz+AnXAE17Q9rJ9xs/L0sJ+qNzmA9Gpvnn1bQLla7X+BuGZ
	 zikZ6sUTNU81ShnboJMmBJe4uk7BSuzrxA+Nfijpj+K5B+34k5RwkI6JzYHb8SQZDp
	 TyJDrOE1mlKebiJ4RFX89hjFwMzGBDuGLJIylw/HcIaJfZgpqlgNva9RE6ai7MEGU0
	 fpXB4RvPhBxqA==
Date: Wed, 27 May 2026 17:51:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 7/9] iio: core: Add IIO_COVERAGE channel type
Message-ID: <20260527175131.5ac5b7cc@jic23-huawei>
In-Reply-To: <20260525164013.118614-8-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
	<20260525164013.118614-8-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 19:39:34 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> Add a new channel type for sensors that report fractional coverage as
> a percentage. The sysfs attribute is in_coverageY_raw; after applying
> in_coverageY_scale the value is in percent. The first user is the
> ADT7604 leak detector, where the value represents the portion of the
> sensing element that is wetted.
> 
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Applied to the testing branch of iio.git.
Thanks,

Jonathan
