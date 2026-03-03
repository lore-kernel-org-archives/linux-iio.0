Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E03932C8;
	Tue,  3 Mar 2026 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574084; cv=none; b=jjl7PLQSq/ntN6bdYTHJ9gTlr978MZVPjgIp4vgS17MfBgNqZH6eY8Nbj65oCnDD1C4IFoFHXo3xHxudB7etq6sE7aolVfqDcKlbP5WFWlMXKU/EgwiOSspUSmMIixg0380Y3ZBxBSdxyKjJfVwBjl9dtuvdCVCOyamDeOaGH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574084; c=relaxed/simple;
	bh=gysZCejBxBTfXajmWiUbmoeIMH6b755me82iqNeSceo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+NSTa2IuMLfeR7bNZFjbhVOGxf13KrNU6vFgRy4QgWJ8oFxHq1RzExrMonozu8dCPqhB9RKXd/VRwmyRo9SBhI/lEdkQOH3TufxzY8/8xRy6W19TN7rDQ7iDhvHJxmC9SUQtp+mZu7Gd7O9/s2mVfrkGHqtry8mx5DgsWd+YuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyeMjbyy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyeMjbyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BA3C116C6;
	Tue,  3 Mar 2026 21:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574084;
	bh=gysZCejBxBTfXajmWiUbmoeIMH6b755me82iqNeSceo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GyeMjbyy0hyHBEyAH7vLkoyEiqaMJkiCGJdWKQRs9OojrFyS+RFleXrZwLiGBtYqp
	 9t8U8XaLJtnNN3Ai+zjROrnrT+PI5f6AX0kcGU3S4st3Xpe61WzSPohqNh2rCc3XT4
	 Pk1pwXOJEKamF9mr11z8prmqAXMyukM6g6QX5s9qcjy2Il8/BASacM4j//gXZEVmwL
	 inGJihA8SV2AqlcvLr89Fmyk4hYbsNha8T3mA+YdhqevR0aXC/w5ZDuYNiWgLQKU2/
	 HrrnsCiyy/Z2zTdYwMz2QQ7ISObNt+eOzQIos2qQGTFW8IK+trHImeZEH5ig2GKj0M
	 ETL7bjZ7H7Log==
Date: Tue, 3 Mar 2026 21:41:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Andrew Ijano
 <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, David
 Lechner <dlechner@baylibe.com>
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration
 with devm helper
Message-ID: <20260303214115.4a74b396@jic23-huawei>
In-Reply-To: <51ca89f5-6db7-408e-8590-774286d544ae@oracle.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
	<20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
	<aYTFUMe3jUO_bGCr@smile.fi.intel.com>
	<34bac81e-6a6c-4cf6-b370-beead4f705c1@oracle.com>
	<CAHp75VfSYGoNUTqDb9WLYNYeChkB4mM+LEBpyRVnLOEKkr==WQ@mail.gmail.com>
	<437592e6-460d-435d-bd83-7ff8222a6130@oracle.com>
	<aYTPkt5jKoX3X_4i@smile.fi.intel.com>
	<20260205195845.4e108117@jic23-huawei>
	<51ca89f5-6db7-408e-8590-774286d544ae@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Mar 2026 17:44:28 +0530
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Hi Jonathan,
> 
> >>>> Ideally it should be done in this patch, but let's wait for Jonathan.
> >>>> He usually may tweak these small things when applying.  
> > I removed it.  
> >>>>      
> >>>
> >>> Also, while checking the patch now, I see I copied a wrong tag(RB with
> >>> missing r in baylibre from [1])  
> > Fixed that up.  
> >>>
> >>> So that's one more thing to fix. Let me know if v6 would be a preferred
> >>> approach, I can do it.  
> >>
> >> Let's not hurry, wait for Jonathan to decide.
> >>  
> >>> [1] https://lore.kernel.org/all/a5fa2f97-9ba3-4085-bfaf-a255d24a81f0@baylibre.com/  
> >>  
> > 
> > And applied to the testing branch of iio.git.  Note this will be
> > rebased after rc1 is out before I push it out as a branch linux-next picks
> > up.  
> 
> I don't see them here: 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
> 
> Would it be easier if I send a V6 ? With everything fixed.

Gah.  I managed to eat the temporary branch i was using due to the odd timing.

Good thing you raised this as it had quite a few patches on it :(
Someone else reported a missing patch the other day but only the
second report made me wonder if I was going crazy and spot what I'd done.

I've cherry-picked everything off that branch onto the one I accidentally
switched to.  So 'now' testing should have the lot. 

If there are additional changes, please send them on top of the testing
branch.  Thanks again for raising this!

Jonathan


> 
> 
> Thanks,
> Harshit
> > 
> > thanks,
> > 
> > Jonathan  
> 

