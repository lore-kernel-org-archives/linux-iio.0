Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982458;
	b=3lrArGsBltQFmWfMyQuCQuUwBjWWcV5AR+5fQvTqo+HRgjBuymDWHwK6W0rVYr/ZQ62r
	 lQlUK3mGRMWR402n92ETaALGtq/MKu7a4YebP1QRlYx9IN2vlG1MRpnmL8YdR2Qv1yZMQ
	 HoFsHxSDoVyZ1gbzJG/wu/NM2UwIZlWdMmfW7g36KDXXzYyHsoaKrCBK6O3JtnkYpsB63
	 q14kNkhGvpBRr+ZflPcB41t8VteMSCwH/83xfMj45LkYKfeholMRYX2saFISHhKFxIHhw
	 nkrXREwW6hpyOhZ16Gv+8beoio0ICfD3gQOMYjnT4p3j1a5QbK4Je6/un1+QkcPihvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982458;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vMduSqZGsc9f+qjSdR1aqHK+wgdnsPTQvPLBByERgyA=;
	b=SRZlzNRMaHg2QMkdi3xhlyv/vy471a7s90dKHPU+Kr7EbUqvQImLxQkySXPpFaoQMYtH
	 7Bdw3REuOiBIh1zT5D063b8af8OxeXdGeszLO6Fhfp2ubqYCSr70w/Pj6ke0kKMOZbBFc
	 cDVbCUQtrkac4LPnzIK5slA0TWJssHinKGEsibZve/AQ/jAdpUpssFsNOtkm3A4bNDGq5
	 jxe+qYbYuTUq7opnig7irN3iZbhpkG9m/66nJTgh4NLMd3mM9beG1SqcvwnjuzvMePSNT
	 xMu+zrWWx4gOs5VRNi/pdwbA27+DDfbNdcPgkQwNcyvKEZzvGqabbQu6JSzTNZNFdMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0qbVUKG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B5606A31A;
	Mon, 26 Oct 2026 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0qbVUKG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B145D1F01825;
	Mon, 26 Oct 2026 02:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792982458;
	bh=vMduSqZGsc9f+qjSdR1aqHK+wgdnsPTQvPLBByERgyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m0qbVUKGhgk60ZMuW9NZ6Y2s18B9Wyn3S7KcQt1tSbs6l3IODAPoKRb63hfspMTvG
	 +QODx+t8+Y4FJcdWKUxjqCqZpVj25PIUTG5MUfLB6sQl2mHiG0SEW8jJOhLqTzkLyg
	 SYPZrtU9O5GVi1J6VcM+mztC6GWewPZpYCUqL3uVMuoLA5KyXRt3nwYYpIKyFzWjtV
	 ps7lJSK0XUXz8J2gUxEY1Um6EWcLl9WQvCwzEti8nbJ6h40FKECGhcAHagx5ApKPJY
	 wWWrPebAJQGeqx/k8S0UKt7ty9XKN8lsjoZJlAx2Hypa8Zxa5mrRTDtSdi8WJk8pAQ
	 CT5yd9SN5TXAw==
Date: Mon, 26 Oct 2026 02:40:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nithishvelan M <mnithishvelan@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nuno Sa <nuno.sa@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use
 guard(mutex) in ad5933_show()
Message-ID: <20261026024049.556c6642@jic23-hlaptop>
In-Reply-To: <atZq2GstK_rxOgbj@ashevche-desk.local>
References: <20261019150248.416-1-mnithishvelan@gmail.com>
	<atZq2GstK_rxOgbj@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 22:09:12 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 19, 2026 at 03:02:48PM +0000, Nithishvelan M wrote:
> > Use guard(mutex) to automatically manage the state lock in
> > ad5933_show(). This simplifies the function by allowing direct returns
> > from each switch case, eliminating the mutable return variables and
> > manual mutex_unlock() calls.  
> 
> ...
> 
> >  	case AD5933_IN_PGA_GAIN:
> > -		len = sysfs_emit(buf, "%s\n",
> > -				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> > -				 "1" : "0.2");
> > -		break;
> > +		return sysfs_emit(buf, "%s\n",
> > +				  st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1 ? "1" : "0.2");  
> 
> You can (re-)use ridx here as well
> 
> 		ridx = st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1;
> 		return sysfs_emit(buf, "%s\n", ridx ? "1" : "0.2");
> 

Maybe call it something else here as its not the range index that I can see.
