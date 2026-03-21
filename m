Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB331F997;
	Sat, 21 Mar 2026 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774096936; cv=none; b=Q00+siI0H23dh720xJGCdhMLllH2aCO5BSBhDlS+3PzL3Hu/5f0peTNYB4f2OQdavDA/XWUCAvtOTXx0GXsbPg4iuX3vwSR3T7s4WNq7WUKnSKhMsqFa5TvVLNz7LwH9MhUqxEt0bBlJjnoQlE31SmsEHhVepoFbbDQmkHLWE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774096936; c=relaxed/simple;
	bh=rfS9P7HZg1H5m5gsInzMgYfpKuGaT7vB1pKpKiIPCKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Idy2m3+sT+W3vNc2l3OdwSgDfBVGXl9Fshr+c220iPXTsgASDKEEzKE/vWK51nh1ZUcR5+RKRXnuj6jNz197R/F2CDstaEjty9Rmvj6GtEmvABKbSKC/vq1vCfvGXla1ZWfsbvJDOKF110neiAStwAkQU5xQ4vxdarP6izptQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALxH9VUA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALxH9VUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D31C19421;
	Sat, 21 Mar 2026 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774096936;
	bh=rfS9P7HZg1H5m5gsInzMgYfpKuGaT7vB1pKpKiIPCKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ALxH9VUAtW8QJ/VmhVQI3QumWRUWrTUeKc+U1wxVXyoJ+xjkGvUSQ3P7RN8UjpPOQ
	 enRJEMZ3WSttgqR5v7JRK+RqEtg+SUeyIC6hCdJO1+1ZOrN+Z5QsABp+hkEbhCDajG
	 V3qJwSdYW8ZRCJ8rblOg3ouUsjGIY4L7V0mkiv2Enpdjba0K5ZqCIj0nHKQPK10b/D
	 2vbte73zmjihLRIaW+0nrrOGoxAHlgEcwe9sf111VCx63Tis4Pm8D2eDc16h6nIBev
	 q/ZNTatGgPJ5//OUEtjW7Oc6hyeEJzKSFZmFJ0bOqczD7M78xzT0Mqkn7jJ7n8IsGP
	 insnItg4Lw5FA==
Date: Sat, 21 Mar 2026 12:42:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Erikas Bitovtas <xerikasxx@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter
 Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, Raymond
 Hackley <raymondhackley@protonmail.com>
Subject: Re: [PATCH v6 0/8] iio: light: vcnl4000: add regulator support
Message-ID: <20260321124205.60ec0b5b@jic23-huawei>
In-Reply-To: <ab2hZXdinHWNYB9S@ashevche-desk.local>
References: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
	<ab2hZXdinHWNYB9S@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 21:35:01 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Mar 20, 2026 at 06:45:35PM +0200, Erikas Bitovtas wrote:
> > This patch series introduces support for voltage supply, I2C and cathode
> > regulators. This fixes an issue where if a regulator is shared between
> > the proximity sensor and some other device, and the other device is
> > powered off, the proximity sensor would be powered off as well.
> > 
> > One of the commits includes a Reported-by: tag without a Closes: tag -
> > the report was done outside in a Matrix channel. A link to access the
> > report requires sign-in, therefore it was left out.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> For the series, except the DT binding, I haven't even opened that mail.
> Also you can add Suggested-by to the selected patches.
> 
You do like to challenge b4! :) Hand removed the tag it added for
the DT patch.

Series applied to the testing branch of iio.git that I'll push
out as togreg once initial build tests are in etc.

Thanks,

Jonathan


