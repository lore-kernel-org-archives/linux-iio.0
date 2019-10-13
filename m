Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A639EC4360C
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 08:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762CB206B7
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 08:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570954893;
	bh=61d/Q41SdPJUgW0JO4GIAqHbF6d3o8AkapbfXrmXSn0=;
	h=Date:From:To:Subject:List-ID:From;
	b=UHhR0784YkUWI0Ed0ZtS0TKWz9m7P5grCPcXJeObEg1/6G3CPNft/xI9odebc2xL/
	 6Dlr4+hLOmAwTd+G35YLc4g7YswD8YaWqjZFLm1itKtw4QqIibBctpeCrAiocE1U82
	 xVufKmiG/nH5zhwg3N7aUk50jNEe43I+PjvGD7Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfJMIVc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 04:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfJMIVc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 04:21:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2CC6206A3
        for <linux-iio@vger.kernel.org>; Sun, 13 Oct 2019 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570954892;
        bh=61d/Q41SdPJUgW0JO4GIAqHbF6d3o8AkapbfXrmXSn0=;
        h=Date:From:To:Subject:From;
        b=UodRSNzzv8+Dj9NNIRzBM+cTCI+AB/ykSLtsDZOZVqljVK2lw2gNMXLfK4VDfs86c
         iSs0izOOUW6rDjkySnalm/CBXl6qIfeWhCnyItqA9JxX7J8oe/nBvoEs14FgvFWgdI
         +NbgotDQTIjC4DW5dL96A/70A8WbdzrphbnmdQDI=
Date:   Sun, 13 Oct 2019 09:21:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Subject: Note IIO togreg branch rebased.
Message-ID: <20191013092128.6ca0f756@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

I normally try to avoid doing this, but unfortunately needed to
drop a series from the pull request I just sent out.

This may cause anyone who was based on top of the togreg branch
to have to manually reapply their local patches.

Sorry about that,

Jonathan
