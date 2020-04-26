Return-Path: <SRS0=UcXy=6K=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD1C54FD0
	for <linux-iio@archiver.kernel.org>; Sun, 26 Apr 2020 11:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441602075B
	for <linux-iio@archiver.kernel.org>; Sun, 26 Apr 2020 11:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgDZLTM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 26 Apr 2020 07:19:12 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:5919 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgDZLTM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 07:19:12 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5127B240008;
        Sun, 26 Apr 2020 11:19:10 +0000 (UTC)
Message-ID: <faf0bf3315c93fddee4f4cdb890bc5e80701c8fd.camel@hadess.net>
Subject: Re: [PATCH v2] iio: st_sensors: make scale channels also shared by
 type
From:   Bastien Nocera <hadess@hadess.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        =?ISO-8859-1?Q?Ga=EBtan_Andr=E9?= <rvlander@gaetanandre.eu>
Cc:     linux-iio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Date:   Sun, 26 Apr 2020 13:19:09 +0200
In-Reply-To: <20200425181359.1e30e315@archlinux>
References: <20200423121714.607262-1-rvlander@gaetanandre.eu>
         <20200425181359.1e30e315@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-04-25 at 18:13 +0100, Jonathan Cameron wrote:
> On Thu, 23 Apr 2020 14:17:15 +0200
> Gaëtan André <rvlander@gaetanandre.eu> wrote:
> 
> > Scale channels are available by axis. For example for
> > accelerometers,
> > in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are
> > available.
> > 
> > However, they should be shared by type as documented in
> > Documentation/ABI/testing/sysfs-bus-iio.
> > 
> > For each sensor (acceleros, gyros and magnetos) only one value is
> > specified
> > for all the axes.
> > 
> > Existing, by axis, entries are preserved in order to to leave the
> > old ABI
> > untouched.
> As I mentioned in v1, there isn't a strict ABI rule that says that we
> must
> do the shared form
> 
> +CC'd Bastien for comment on what userspace is assuming and whether
> we should
> push this back to stable or not.

I have no idea what the effects of this would be on the ABI, and how
this would impact iio-sensor-proxy.

Code is here though, so it might be best to test it:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/tree/master/src

And we accept merge requests :)

