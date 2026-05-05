Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6FE316197
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997696; cv=none; b=slT6mHzEObhlcl8kKtSYC362VxMB6ZvS7W6B4FZwvpWYIVSKnT8r7xKFrBqHt+zxtQFSeyjM8T8nX7dBqOP2utLa6MT31z+z4J/zX3sVIRxUIcxV7vF+AlHeLksHQv4pt+UXkQBfQOciU7LAJwBcqRWlOJixFmJmnZ7O3Zu6De4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997696; c=relaxed/simple;
	bh=P/tGebxhrzexD0gq+Owzt5kDG6NpwUHokwnA3noH0vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4iuZ0983ZYZGIbFHgargkBXnQJUs+33+RyZxm7aTPOzRvUIrwyz/VaRILc9ZQufwCwjdic6SPQqG0/qZwhQJIa8lqOcqhbG/bzlcxz/hAn7aKB7oRO4tIH4tDpt/ieA29NteEPDxZzgXQJ2fJ7DzI6qG5C0VITbEWl7cevpyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni2PpW8a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni2PpW8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6DBC2BCB4;
	Tue,  5 May 2026 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777997695;
	bh=P/tGebxhrzexD0gq+Owzt5kDG6NpwUHokwnA3noH0vk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ni2PpW8a1EfsR6SCHl+ehVAiiehHSermrRXtAXyMbqaNHtZEEl3FAnYshUK+T+2UT
	 YUm0AGsiC9CvuEojp/p9Wcaq98mdOIsvpUw9qfzy9PqZlI4cqwDmwx2GFhtUMtoV8g
	 J9MTEJLqdjs7FB+gXYM8e/XDehlUhaPAtIf6Y81rypvHZoZGuTg+yK9Tnb+QsLz4yu
	 fiuJ8Gm1mOD75CR7+tqIIR8kDWnBcfxGyYawnbLeo9ZJQA3HORl8gChn7ei10oOkf7
	 F6qWulYlyBiReAmie/nl7MGoypPTy2mskYW6BZ7QqOoQGmeKAy8HWVbrFhkKFZqif7
	 EdYpxLO0MIyww==
Date: Tue, 5 May 2026 17:14:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rafael Lopes Santana <santanarl@usp.br>, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Replace manual bitfield manipulations with field_get
Message-ID: <20260505171448.5a5e4c11@jic23-huawei>
In-Reply-To: <946edc28-dbf4-490a-98df-615e1a4f6b21@baylibre.com>
References: <20260501011548.15369-1-santanarl@usp.br>
	<20260505131642.75f3c72a@jic23-huawei>
	<946edc28-dbf4-490a-98df-615e1a4f6b21@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 08:52:44 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/5/26 7:16 AM, Jonathan Cameron wrote:
> > On Thu, 30 Apr 2026 22:15:46 -0300
> > Rafael Lopes Santana <santanarl@usp.br> wrote:
> >   
> >> From: Rafael Lopes Santana <santanarl@usp.br>
> >>
> >> Signed-off-by: Rafael Lopes Santana <santanarl@usp.br>  
> > Hi Rafael,
> > 
> > Additional comments inline.
> > 
> > Given this is packing code that is using shifts in one direction even
> > in your new version I'm not seeing a clear advantage to this change.
> >   
> >> ---
> >>  drivers/iio/proximity/aw96103.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> >> index 3472a2c36e44..a8a6ae02438a 100644
> >> --- a/drivers/iio/proximity/aw96103.c
> >> +++ b/drivers/iio/proximity/aw96103.c
> >> @@ -591,7 +591,7 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
> >>  	}
> >>  
> >>  	for (i = 0; i < aw96103->max_channels; i++) {
> >> -		if ((aw96103->chan_en >> i) & 0x01)
> >> +		if ((field_get(BIT(i), aw96103->chan_en)))
> >>  			aw96103->channels_arr[i].used = true;
> >>  		else
> >>  			aw96103->channels_arr[i].used = false;
> >> @@ -643,10 +643,10 @@ static irqreturn_t aw96103_irq(int irq, void *data)
> >>  		if (!aw96103->channels_arr[i].used)
> >>  			continue;
> >>  
> >> -		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
> >> -			      (((curr_status_val >> (16 + i)) & 0x1) << 1) |
> >> -			      (((curr_status_val >> (8 + i)) & 0x1) << 2) |
> >> -			      (((curr_status_val >> i) & 0x1) << 3);
> >> +		curr_status = (field_get(BIT(24+i), curr_status_val)) |  
> > 
> > Look at coding style for the kernel. You are missing some white space here.
> > 
> > I don't like this but if you were to do it for consistency it would be
> > 
> > 		curr_status = FIELD_PREP(BIT(0), field_get(BIT(24 + i), cur_status_val) |
> > 			      FIELD_PREP(BIT(1), field_get(BIT(16 + i), cur_status_val) |
> > 			      FIELD_PREP(BIT(2), field_get(BIT(8 + i), cur_status_val) |
> > 			      FIELD_PREP(BIT(3), field_get(BIT(i), cur_status_val);  
> 
> I actually find this much quicker to understand the intention of the code.
> 
Ok. That's a clear vote in favour, please respin it like this for v2, remembering
to deal with all the process stuff others have highlighted.

> > 
> > The benefit of that is slightly more than what you have but it's still ugly enough
> > I'm not sure it's worth doing.  Note FIELD_PREP() in this direction as the mask is constant
> > 
> > Given the bit smashing going on here is always going to be ugly I'm not sure
> > any of these are better than the original though I'm open to hearing what others
> > think of this more complete version.
> > 
> >   
> >> +			      ((field_get(BIT(16+i), curr_status_val)) << 1) |
> >> +			      ((field_get(BIT(8+i), curr_status_val)) << 2) |
> >> +			      ((field_get(BIT(i), curr_status_val)) << 3);
> >>  		if (aw96103->channels_arr[i].old_irq_status == curr_status)
> >>  			continue;
> >>    
> >   
> 
> 

