Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D83451DA;
	Wed, 13 May 2026 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687706; cv=none; b=rKo8ee0N6XGuSiiTIY8cWPNHZDejte8JnxwBdwSr9LvnIhgdN4Vt/JPvl0Yhq1M3nuotX9GNmS+8gBa3zGPeEkpU2qn7rQ0qvs9gRcY03HNiwZ0mHDAHJu+12DfH6lqufKuDyH2pLH8udxdsa7WogzWVoTMG1RbbGteF2opsnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687706; c=relaxed/simple;
	bh=63Rf4EzdYy/zSeTbMnubCgybfshJaP95FPUpyjaMCuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmtMILWsf0SRGRTjJrpoLxFwc+Ox3bYKKoDALklwu0+feiC6DUN6MDkN08DmVUNHbFXLNg+nWcYTu/0gsGBXvGzkN4FNgZrP436FWPi4ZofSbdg9Es1HtvV+bxaOo+zMR/gnuXDNcPCVZrbmaPOqJc0li5I21EYTVaMq4P/ni48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9IaSv4h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9IaSv4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AB1C2BCC6;
	Wed, 13 May 2026 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778687705;
	bh=63Rf4EzdYy/zSeTbMnubCgybfshJaP95FPUpyjaMCuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y9IaSv4hDItFGCMGlAD2hsld4znOdUBjY0ZWTXp5TjUqy5Dq9ZBO/56TJBMewmPhn
	 zNKgoznwumXOojZnI3Wv2VV0bStm1s8RmNjcWtreTn0CEZM5ZTTJhemJYXfIgw3yfl
	 XFGM6D/sVrSkshMLBSLTfMOJ0/6IJzuvcHrItKol5ef/wKIqP/8VeNP3+VObice8RZ
	 mndVffWX14bCcdPRWjOymO1xJHziWiWq1Tp+YSHndPaGx6I6YvXF5/wgw8NzODYYp3
	 Q24iVa2dwq3I7CreacZDfkQHFqOG30n1vjNwdZB0dXqYAF5MmBOfJ5HXJk4uaJiDBF
	 ijf2d+jwrfWSw==
Date: Wed, 13 May 2026 16:54:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: arthur.becker@sentec.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6040: add suspend/resume support
Message-ID: <20260513165458.7ec5468a@jic23-huawei>
In-Reply-To: <20260513142632.9445-1-sozdayvek@gmail.com>
References: <20260513094536.8038-1-sozdayvek@gmail.com>
	<20260513142632.9445-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 19:26:32 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> On Wed, May 13, 2026 at 19:15, Jonathan Cameron wrote:
> > Suspend / resume tend to be a little non trivial to add and datasheets
> > are sometimes less than perfect in describing powerdown modes, so can
> > I confirm: Do you have one of these that you are testing this with?  
> 
> Honest disclosure: no, I do not have a VEML6040 board to test with.
> The patch was prepared from datasheet inspection only (Vishay Doc#
> 84276 Rev. 1.7, Tables 2-1 and 2-2) plus the existing in-tree usage
> of the same SD bit in veml6040_shutdown_action(). If lack of hardware
> testing is a blocker for a PM addition, please drop the patch; I am
> OK with that.
> 
> > dev_get_drvdata() rather than going in circles. It's get of
> > 'implicit' knowledge that works for i2c sequences like this  
> 
> Noted -- if this stays in scope I will switch to dev_get_drvdata(dev)
> in the suspend/resume callbacks.
> 
> > Andy pointed out regmap_clear_bits() is handy here and set_bits above.  
> 
> Yes -- Andy made the same suggestion on v1 and I have a local v2 that
> uses regmap_set_bits()/regmap_clear_bits() (and applies the same
> simplification to the existing veml6040_shutdown_action() for
> consistency). I was going to send it after the 24h wait, but happy
> to hold it until the hardware-testing question is settled.
> 
> Stepan

Hi Stepan,

Given you are becoming a frequent contributor (which is great!) can you
look into why your emails have the in response to set to your last
email not the one you are replying to.  It's making for hard to track
threads in claws-mail!

As to the hardware thing - let us wait and see if anyone surfaces
with an offer to test.

Thanks,

Jonathan
