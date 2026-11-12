Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474782;
	b=oG/BNOVQeoRymI6kQyuVrUWxVXAdat6qvD6RhSGQUoHXsZuHkT61v6vh2zaOygi2AXgY
	 WPlzm/1l9ZAVOZs5Pzxm4JWT6dZEmbw1fvynHxM6/rMob0ZDj5w3j3l5Vx2IGis9Ac12Z
	 rqlqkfztRDYGKyGBS38w/Hsw9OoXr6hHHs7irxgkVMGo4E0oH+Nlr4/uE5D+lYl8xl+Y0
	 rbxuwxTtWTKfbCJPk14ohf2ibA1AAan1cMJQ51Th/PC69kSJt8kz+6Go0Ruc5T0uApw09
	 hbTxIUTy89aKEuHlg8sN/Ib1xH/LQHouwQXhY4kTwZcawlZRVL++BAVLvqdw7zF2AhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474782;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ft2tBQ+0c2FdUlVmrJHX4BXC0U6144CNBjfBz2Vuq04=;
	b=DO/S+pszU1nM4kK6srqX838Zl/0h886f+madxQRlRw7Jh4bipqQhseV48kMgjlMB4tGp
	 pyDl2IvEqxpWr7oV5VuWx1ofEbSneBBWyVtgh2a8LRxaV/W733ofiUlLy2teJaLuImycP
	 Rlwnm4+MWmmI7s8r8r8sKTvMrC8MJVLgTjV/X6CpQJAhT6sfvjP5WIngyR8o+6lcrT++Y
	 PUFWk/rUogPxjm7RrMZYILiQ6tdqI3gtU/FKIqUFqEswscpyaULLemwidSGvTK0W85n8G
	 lA6WJAdYOcDBMGhftkO0EN3Pglc/r6G5LO69TV7dz7Iq75xzeJYqEDqnd9QDJx0FO9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LIOWiixC;
	arc=none smtp.remote-ip=95.215.58.184
Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7D606A336
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 09:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFC7D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LIOWiixC
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=++shdLX4b8cAwUm0fcKeSGv4KLpX5SD1g9rB8e8HSkg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794474780; v=1; x=1795079580;
 b=LIOWiixCgrZdIUTyS88m4+8HSif2r3pj4jR0HQo/1euwOSbo29uOA3r792wz9wGPhyVpM5un
 neN1APLEauzpMhRGM3OfZcy8DTe4P/X6gGGM+tKsAX2pi5od72K6zh7x/e292E0cJGEkTpYXniZ
 4Nb3hPQvRP8S/lYRbBvNqmdM=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 684e379d45c249fa;
	Thu, 12 Nov 2026 09:12:59 +0000
X-Mizu-Trace-ID: 684e379d45c249fa
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 09:12:53 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, crofts@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	akhileshpatilvnit@gmail.com, akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v3] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261112091253.GA3634242@u5ce4748bae3b54.ant.amazon.com>
References: <20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com>
 <avLr27SlZWwFnpYY@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avLr27SlZWwFnpYY@ashevche-desk.local>

On Tue, Nov 10, 2026 at 12:03:07PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 10, 2026 at 05:29:42AM +0000, Akhilesh Patil wrote:
> > Move to my new linux.dev email address akhilesh.patil@linux.dev
> > I plan to use this email for kernel development going forward.
> > Also update email address in few yaml and driver source files.
> > 
> > Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
> > ---
> 
> > Link to v2: 
> > https://lore.kernel.org/all/20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com/ 
> 
> And where is changelog?

ok. Added entire changelog v2->v4 in version 4. 

Regards,
Akhilesh

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
