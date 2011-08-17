Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58111 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab1HQKJH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 06:09:07 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: greg@kroah.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/2] sysfs: Allow for groups with no attributes - grp->attrs = NULL.
Date: Wed, 17 Aug 2011 11:17:02 +0100
Message-Id: <1313576222-27743-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313576222-27743-1-git-send-email-jic23@cam.ac.uk>
References: <1313576222-27743-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

One approach to handling case where all attributes of a subdir are
added independently via sysfs_add_file.

Usecase - iio_chan_spec device registration sometimes creates all the
elements of a subdirectory (e.g. scan_elements) rather than adding
them to an existing subdirectory. Right now the core provides 'dummy'
groups for this purpose, but that's uggly.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 fs/sysfs/group.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 65d6d78..25fe548 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -22,6 +22,8 @@ static void remove_files(struct sysfs_dirent *dir_sd, struct kobject *kobj,
 	struct attribute *const* attr;
 	int i;
 
+	if (grp->attrs == NULL)
+		return;
 	for (i = 0, attr = grp->attrs; *attr; i++, attr++)
 		sysfs_hash_and_remove(dir_sd, NULL, (*attr)->name);
 }
@@ -32,6 +34,8 @@ static int create_files(struct sysfs_dirent *dir_sd, struct kobject *kobj,
 	struct attribute *const* attr;
 	int error = 0, i;
 
+	if (grp->attrs == NULL)
+		return 0;
 	for (i = 0, attr = grp->attrs; *attr && !error; i++, attr++) {
 		mode_t mode = 0;
 
-- 
1.7.3.4

