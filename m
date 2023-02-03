Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD20DC61DA4
	for <linux-iio@archiver.kernel.org>; Fri,  3 Feb 2023 14:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjBCONg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 3 Feb 2023 09:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjBCONW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2023 09:13:22 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBD623591
        for <linux-iio@vger.kernel.org>; Fri,  3 Feb 2023 06:12:14 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 24830DF00BC; Fri,  3 Feb 2023 15:12:11 +0100 (CET)
Date:   Fri, 3 Feb 2023 15:12:12 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     linux-iio@vger.kernel.org
Subject: iio dac drivers : imposing upper limit on value.
Message-ID: <20230203141211.GA28086@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

the board I work with incorporates two DAC's, but the hardware men
told me that I may not use the full range of the values allowed by
the DAC component in order to save the lifetime of the chips (LEDs)
that are feeded by the DAC.  My specific case is that the DAC has
a 2.5V Vref, but the output accepts maximum 1.24V.

I would like to describe that limit in the DT and enforce it in the driver.
Is there an agreed upon property for that, and a sysfs value to show it to
the user ?

Best regards

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
