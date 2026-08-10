Received: from out-2z4y-a131.jellyfish.systems (out-2z4y-a131.jellyfish.systems [198.54.127.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719D1A38F9
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398752; cv=none; b=njx/yyyqSkxYaUnm6lfNs1xG5xpW9nJCMis8HUzgV9jty9MroKbfBzLyh1rXT6IrMGHbk+FSSlezpBnolYv7u9qYqus456ftZvV4neuGvxVm8D6HWVkye1o0gg8Oo570E/ofHavNQ55z13YCvninD28rWPsJwYKvf/+Pcfa6pmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398752; c=relaxed/simple;
	bh=9MOqCZ1dfc/gkJyWImO0IXYe1FISFO4YF5zo8qm9SuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpkW/EVpzVUhN+TI2A7Ps85Fx+h9ji81OrXrG8QOIe/ueapuvrOQkPxbEVg5RbXRJdYMILoQjHGTpSO3uSxv9RoxTx/J5zIToK6U6pu/0M8E8/O5OcYWCLzyD6TEwcYUxkhxvlPkKldfwxftzboe63iA4/2Dnox3SxIga3/WkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hJpPc4f3WzyNS;
	Mon, 10 Aug 2026 21:52:04 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 2/3] iio: light: stk3310: add per-chip match data
Date: Mon, 10 Aug 2026 23:51:57 +0200
Message-ID: <20260810215157.154384-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anoZwgq6ZO_VY064@ashevche-desk.local>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net> <20260810110423.41697-3-jorijnvdgraaf@catcrafts.net> <anoZwgq6ZO_VY064@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

On Mon, Aug 10, 2026 at 09:34:42PM +0300, Andy Shevchenko wrote:
> > +	chip_info = i2c_get_match_data(client);
> > +	if (!chip_info) {
> > +		/*
> > +		 * Clients instantiated through the sysfs new_device
> > +		 * interface under the lowercase compatible-derived name
> > +		 * have no firmware node and do not match the uppercase
> > +		 * id table entries.
> > +		 */
> > +		chip_info = &stk3310_chip_info;
>
> This is an interesting comment and approach.
>
> > +	}
>
> - Where does this lowercase come from? Is it Linux forced conversion?

No conversion - the client name is whatever is echoed into the sysfs
new_device file, and the lowercase spelling is the one that binds via
the OF table: for a client with no firmware node,
i2c_of_match_device() falls through to i2c_of_match_device_sysfs(),
which matches the client name against each compatible and its part
after the vendor prefix, so "stk3310" binds through
"sensortek,stk3310" - the same lowercase name a DT client gets from
of_alias_from_compatible(). The id table lookup stays case-sensitive,
which is why i2c_get_match_data() comes back NULL for such a client:
device_get_match_data() needs the firmware node it does not have, and
i2c_match_id() only knows the historic uppercase names.

> - What's wrong with simply failing the probe?

It would break a path that works before this patch: probe consumed no
match data, so "echo stk3310 0x48 > new_device" bound and probed fine
(we used exactly that during bring-up, before the DT node existed).
Failing it would be a userspace-visible regression in a patch that
claims no functional change.

> As far as I understand the problem is preexisted. Or was there any default
> taken? How do we know that the chosen default is a good one?

The path preexists; only this patch makes probe care about match
data. Before it the driver had no per-chip data at all - every client
got the same two channels and the hardcoded "stk3310" name however it
matched. The fallback selects stk3310_chip_info, which is exactly
that, so a client that probed before this patch behaves identically
after it. What the default cannot give is the new part's extra
channels: an STK36C61 instantiated under the lowercase name gets the
reduced legacy profile, and the id table spelling "STK36C61" selects
the full one.

Thanks,
Jorijn
