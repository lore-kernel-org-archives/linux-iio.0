Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C63407592;
	Wed,  3 Jun 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484418; cv=none; b=BbZb3z+fYbTUZXG3zx2L8qs7N1sfmSxL4OI+SDTsHdhD0D1nSreR7m/fS1jfantWVtIHutho9LVSNEtHiPNY5wikO2h8GfcbTxsSiZVR45Hzx15Z6m+Gas68gmFma0UXgBjphHFMjXr1zNk/xZPkZsozCRAqc7BfqM53jSisLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484418; c=relaxed/simple;
	bh=CNKaYB54oesFqwBIzQmDKJ/yEIlcn80va8CAKp3e1sU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeP0CZnoeRI8UGTZYN22tPgCGuacDagZIjVCoOXSiZy92HIr1ngm+arol4Qw7hNHkWb4QGImss//qduhB9Lv2pmOUiiMrg2Fc5tcM41ZQvTcPnnXK3fEmia5NO+QGF+PWzJyv5RV30Dt9W7yTz1kjWMx6kA2ZI7kNEF+KwWgQYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq5uNue8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq5uNue8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435151F00893;
	Wed,  3 Jun 2026 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484417;
	bh=1CgUjNlMw9S52nRCDvi21p+Qt+QcAgx6DMINQg+4PHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iq5uNue8uLn2kifGX1Pqf2UNIM8caqsqmvUD/8US+upGUD/k2XcU697qVf0WaAqYx
	 Q7uEoSkobOaFyElfddC6jkngMUeOD5eXdba9j/ouXhVzXNxO5RZyxau5K0qUfBw5gG
	 nU8DXr9uWKTaSSTQsQcCIUwec9w3JhGqsi2ZmpLpnvzG/cKAyXcQrF5DdNenFCwMHr
	 N0zKCNs6oksnPxwxZiGloT/pRqmHjR70dGFDGgrtbfVPmj5rsOCnAf9jwebrbhjVDn
	 m2RIcg4RtOPGZETb/RWSmJX6OBbUyPt07xGr+GwQbiVRzH4IGSujYyUX5s+AwGhpk5
	 /XYQJhvRLsaQg==
Date: Wed, 3 Jun 2026 12:00:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Jad Keskes <inasj268@gmail.com>, linux-staging@lists.linux.dev,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: addac: fix CamelCase naming in adt7316
Message-ID: <20260603115946.34055d3f@jic23-huawei>
In-Reply-To: <ah_Kbff-c38NWV66@stanley.mountain>
References: <20260602190308.158051-1-inasj268@gmail.com>
	<ah_Kbff-c38NWV66@stanley.mountain>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 09:32:13 +0300
Dan Carpenter <error27@gmail.com> wrote:

> On Tue, Jun 02, 2026 at 08:03:08PM +0100, Jad Keskes wrote:
> > checkpatch flagged a few CamelCase names in this driver.
> > AIN and DAC prefixes are lowercased as standard kernel style.  
> 
> The AIN things aren't an issue and checkpatch doesn't complain
> about them.

Also they are userspace ABI.  Admittedly this is in staging and that
ABI is completely none compliant with IIO standards, but none the less
you should be very very careful when making that sort of change.

This driver needs a mass of work to drag it into the modern age.
IIRC there have been a few partial attempts at that in the past.
One key part of that is most of what you are touching in this
patch is in code that will not exist after this is modernized.

I'd be surprised if there is low hanging fruit like this that actually
makes sense to do in the remaining staging/iio drivers. 
Mostly much more radical surgery is required.

Anyhow, with that all in mind I'm not planning to take this sort
of change to this driver

Jonathan

> 
> > Vref is kept capitalized since V stands for Voltage and is a
> > proper technical abbreviation.
> > 
> > DA_AB and DA_CD are renamed to dac_ab and dac_cd to match the
> > register constants ADT7316_VREF_BYPASS_DAC_AB and
> > ADT7316_VREF_BYPASS_DAC_CD that they reference.  
> 
> This sort of change would need to be in its own commit.  (We're
> dropping the rest of the commit anyway).  The difference
> between DA and DAC is not totally clear to me...  The
> adt7316_show_DAC_2Vref_ch_mask() function only seems to deal
> with DA but the adt7316_store_DAC_2Vref_ch_mask() does stuff
> with both.  So I'm not sure I understand the naming.  (I have
> not investigated and this is my first time to look at this
> code).
> 
> regards,
> dan carpenter
> 

