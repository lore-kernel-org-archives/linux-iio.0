Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEB330DEC1;
	Wed, 18 Feb 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443851; cv=none; b=VvuJ5x50/pAC0t8ozXc1627TM5wiOfhnLKLM3G2BODjSItlZRyQPG599hawRTpcmCkOC6/v0aMFLi+EHxKtxW78Qv3QdCZ98FtOY7P7d/Avjkq2xLZODMRkFks6lJUeepM1Dqa782ccWr39zKRiBu+AS9KP/YH4AMSMvBLP5bg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443851; c=relaxed/simple;
	bh=//qnuWIx2dCsg7BwpRG1Kkg8Q9Vcgf4iee1ksND5Q48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfJmY8A2lE8UDEnQzYGJxVVR3qE5xhMH/WeARZsbzsUEmvAGfBsHyq0U8GQ5ysbccMILeVZDgEp9YNadzfn9Nl9/GSA0jGqqipG7Adp+xc90noHTIxVg8wVwSghpS5neZDrL9K2CZ/Ssbk0GSymlyGRO1BHCom95wiFeIxTT3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5G9R0PG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5G9R0PG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9F2C116D0;
	Wed, 18 Feb 2026 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771443850;
	bh=//qnuWIx2dCsg7BwpRG1Kkg8Q9Vcgf4iee1ksND5Q48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j5G9R0PGvs+JFAUCcxBcVJmK4/OtzPmDiXunJ7wWRCI2g01kN94IkcDh1e/GtPojO
	 o8qSSr55EKdLMLfXEPkq8eB7UuXU928ZD8F9JHs5+MUO2jrklvmik06uXBaapKtOuI
	 zqfpgfFmQocInqnp0LMCsZracBYX7EDT9zCCkuDQTraA24ytjSxQgujbWW6r/XGbpA
	 6R4tcrZgo5LLOlsXB6DP7cMZmAsauvBb/m9aT3o4ojTjD3SZ+a+M0MPP9wBAqPVKp2
	 U5H8mRzdCgGyYWOH/x1OdWyVi6Nu7WxdMFNP3FLg0LQe4dWrG+7u2qNPB1wtO60Wh9
	 4sAhmksOdYseA==
Date: Wed, 18 Feb 2026 19:44:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, Jonathan Santos
 <Jonathan.Santos@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3] iio: adc: ad7768-1: Fix ERR_PTR dereference in
 ad7768_fill_scale_tbl
Message-ID: <20260218194400.5196cd80@jic23-huawei>
In-Reply-To: <aZLIqW1JN34xvQun@smile.fi.intel.com>
References: <20260214184637.16985-1-ethantidmore06@gmail.com>
	<aZLIqW1JN34xvQun@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 09:35:05 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Feb 14, 2026 at 12:46:37PM -0600, Ethan Tidmore wrote:
> > The function iio_get_current_scan_type() can return an error pointer,
> > the return value scan_type is not checked for this and immediately
> > dereferenced which can cause a kernel panic.
> > 
> > Add check for IS_ERR() and propagate the error back.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
