Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49739B94A
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174497; cv=none; b=m57WQ3Cz4PaUhVX5Nn/ppHLDXj2+OU66GkINCsf+9wfuU5rqW/IiwH/sfTFtoZ+nk/2s0Uz2CDPG13sg26fJUflCXiW8QNEZ8auIpEJpdndtN3kSJNJrZViLTFyyl1sV8Hmo7fkMbxHcuH06ImSmdN23OPw6aB3TA2ESQisS3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174497; c=relaxed/simple;
	bh=iHrHqCAXnU6w0OS7DQt+y8wUDDdgUtnC3rGRDaExFLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDoINHRIiIddt2TJB9OEZdRCVk1buYH3DgSHiJB/hoBgTSe47uNtKrdmVwklt9n3jC9yKZVS6qUGZT6GBVMuvkWhSe5EH12/n5Hu1BCXaTgboUsAjp5IIeDYODfmZLj0wv9vNGjJYPaBjg5K6hD4dnT7gwUgWE/VN4Qj9SXHZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8dNnuXP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ne0wFQWb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8dNnuXP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ne0wFQWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pVGzn/bp+HeoWhJcAlXzRJysNeFi8GSJbP12rbQe8Y4=;
	b=L8dNnuXP5IhnrE9VWe2vk74YdnSQra+uTMzoiqaOXRBMPqb3g+goaiMrpqYhkcjluyOp8q
	fT8HwA+vdUIb2YG0ji7tcsAUuKaWbdd4CUIsgNASLCiKjs4/imRxuXp/VPIfJlHP9rfXiM
	7D9Tb3x9eZGF1t6xF6I5nLRwNNUnehQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-iS2R3efgM8y2gLhebnehtA-1; Wed, 19 Aug 2026 17:21:33 -0400
X-MC-Unique: iS2R3efgM8y2gLhebnehtA-1
X-Mimecast-MFC-AGG-ID: iS2R3efgM8y2gLhebnehtA_1787174493
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d7886cdso27007191cf.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787174493; x=1787779293; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pVGzn/bp+HeoWhJcAlXzRJysNeFi8GSJbP12rbQe8Y4=;
        b=ne0wFQWbOks4TH9YSYxP+L3J61lBszhuVxir7D11tT2yHDCd0KwAlcruZTgW8M9CV9
         g3GBB99AlbsxTCrTSyNxMC7sq81OK/2j9HBqPFkEA7Cuc+SRoxWIoUe09KFa3ls7cVE9
         P+RNW3OGxVvIgGOlxLVTVZjGjPqu/CjF2fV6aqi9XZl5K+5uhNxFnIQPBYbGY2B2kKnz
         te/VlM8wPJD1u/COrI6v50PsCxFOEnFQNofjPV1yKklmYDspMn9Hcl6exxZ5hi0JajUr
         35pkqk0pvtYoNfc+ZU7Dz6RUMKXY7BLL/zftRRM/J782wUV7/0VArpnb747VybPxt9ra
         HboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174493; x=1787779293;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVGzn/bp+HeoWhJcAlXzRJysNeFi8GSJbP12rbQe8Y4=;
        b=a5BJqzXaBB9sn5V49KuQ/iESne4YGza/S0vrOAIH2+aBB0vFO3uhtC9mXi2kESNdQ6
         5Y8hDN0ku4Dgvhc2r1aAClPyt2cv+STtKoPqlSY8B5YtrYL9PAXXIuLHcIozv+RL21Tb
         ruendeT/FPk6XttXMSQ0wbPlxesvc5qrsrwQGT+htIcd13zENiyzJG9Q2oFjLv6UyRjR
         dCW3yx5jgZKPThy7oHsSmYoZWrE9asLDSpDFDh+9hYZWUXD4axpWXxYvH6BhyLVgPNYH
         t3pGjHnFb0+cuLxSKBHwag+5cV9BmRWnmYYbxoLXS/LisIhI7k0HYkFgDf9h8c+Wa0PN
         mTXg==
X-Forwarded-Encrypted: i=1; AHgh+RpHyqZfx3LdHnVB7dI6O+o2lrNK/xpmgNtG65mgcENeWqQeh2wFvBiDxe4sWisSCuVCvoCD8QDzj4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxF9pMXu6CFyWU/C5q2VuFscGDNVvf9I6BW88IXOe2dEY/wLP
	VvkpmnvYPRFfZ/mx3jOsEnUHrgNkDTlk05KPJKQooWFirmQMzW613Tg9llZfoBxX6GiaNsTeNcG
	N2DvCqKVmUAZ3Gudva4jqV75oYrwN0cKFInE46IC2O/VmzcjTv3mo5J5/kgKqug==
X-Gm-Gg: AR+sD10JK7i2wswq0Xq/9Kvxcp2CJ9WWyyQRvogYfGclzXsYEuSQDMjLOSiivyyqhhQ
	fBsAjU/ABwhI9B823vAXuK9WolGt7TruFpLL2djvYyDogkPRI9RIC4n1dhSG/icpYixsrj1WXNc
	hyXQaNI1W2wXGJhod847NTBHM6OofwWAv8++9oBxB9FgSxaM3d4kOxmA6/TnuH5FyVj8kvg0xh9
	jOHx2GcTRcAkVBWiLERNMBqFGoNHDwdZnmniFQXMtDqutEtCCKPnKxbtBBLP+rhnwmT3Z+79FZi
	ucgyfptTfJSQv4XNKxyX7xWmnZd7zcigVneMQ4k2G5Q/6N4wNWWsCW4b6TTkIHeZZokLyyETsMj
	NHHiEjBaZNIxOds0X3QqtxvVu9YhQXS49Ehk=
X-Received: by 2002:ac8:5cd3:0:b0:51c:f8f:13e with SMTP id d75a77b69052e-52dd5cf792bmr79425511cf.40.1787174492951;
        Wed, 19 Aug 2026 14:21:32 -0700 (PDT)
X-Received: by 2002:ac8:5cd3:0:b0:51c:f8f:13e with SMTP id d75a77b69052e-52dd5cf792bmr79425061cf.40.1787174492580;
        Wed, 19 Aug 2026 14:21:32 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd8598adcsm18745871cf.9.2026.08.19.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:21:32 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:21:29 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide 2/5] clk: visconti: Make sure clk_init_data is
 fully initialized
Message-ID: <aoYeWR6H3q-d3yd3@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Wed, Aug 19, 2026 at 09:05:16PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> visconti_clk_register_gate() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: b4cbe606dc3674b2 ("clk: visconti: Add support common clock driver and reset driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

