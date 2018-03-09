Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33622 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCIXpf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Mar 2018 18:45:35 -0500
Date: Fri, 9 Mar 2018 20:45:29 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Graff Yang <graff.yang@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging:iio:ad2s1210: Driver cleanup
Message-ID: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset removes some unused #define directive and variables.
Additionally, it fixes two checkpatch problems. Finally, the last patch adds
struct documentation and comments to some part of the code. All of the changes
have the intention to improve the readability of new updates. 

Rodrigo Siqueira (4):
  staging:iio:ad2s1210: Remove end of line with '['
  staging:iio:ad2s1210: Remove unused #define directive
  staging:iio:ad2s1210: Remove old_data from ad2s1210_state
  staging:iio:ad2s1210: Add comments/documentation

 drivers/staging/iio/resolver/ad2s1210.c | 52 +++++++++++++++++++++++----------
 drivers/staging/iio/resolver/ad2s1210.h |  9 +++++-
 2 files changed, 44 insertions(+), 17 deletions(-)

-- 
2.16.2

