Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DCDCDB465
	for <linux-iio@archiver.kernel.org>; Sat, 14 Oct 2023 16:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjJNQvz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 14 Oct 2023 12:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjJNQvy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Oct 2023 12:51:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E72D9
        for <linux-iio@vger.kernel.org>; Sat, 14 Oct 2023 09:51:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1DDC433C7;
        Sat, 14 Oct 2023 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697302311;
        bh=sZgmvpS5HYi/aW382Dggxqbx+LM0JxBDFOyCaPANjGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XeSsR6olXFt3q8LcrlqUJwmuCSNgHAnlcWUmOCSDwBrqmMqnDwubo3Sb7wsuEgzZ1
         XdTDHMhdvLBQ67pvavoNzxuKbcypnGTNNI4OvYgtFdHnhSqg4/vUNdck/XeDL1RdNA
         6AHh8HKWx69qDiabBlB0X6xm7i9R8s46zkI6tzKswmFTn7TkRLiKLsQDGNdW4XsSZn
         OGY7Zs7x1WD7e/mfyh7cSHqWhUXQrKBpXMGNRutro4heOnMVex1EDzkWTdASN8n7uW
         R7+wZtO++ws6J9df8arZOyewjLdlXeu5QxSa5Ieq7C8Vj4H0BOAgDTZRYMiOJnYjKq
         cvypKIyT/qKZw==
Date:   Sat, 14 Oct 2023 17:52:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
Cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
Message-ID: <20231014175206.6b2ff811@jic23-huawei>
In-Reply-To: <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
        <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
        <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Aug 2023 14:22:10 +0200
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> > > The hid-sensor-prox returned an empty string on sysfs
> > > in_proximity_scale
> > > read. This is due to the the driver's scale never being initialized.  
> >
> > What is scale value reporting here? Is it 1.
> >
> > Thanks,
> > Srinivas  
> 
> Calling `read` on the sysfs file `in_proximity_scale` returns 0, thus an empty string.
> Adding the hid_format_scale call makes that a '1.000000'.
> 
> Regards,
> Philipp

Srinivas - I was kind of waiting for a reply to say if you are happy with the explanation.
All good?

Phillipp - this sounds like a fix to me.  Fixes tag?

Thanks,

Jonathan
